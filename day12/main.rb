require '../lib'

include Lib::IO

class Node
  attr_accessor :children, :parents, :metadata

  def initialize(children: [], parents: [], metadata: {})
    @children = children
    @parents = parents
    @metadata = metadata
  end

  def inspect
    metadata.inspect
  end
end

START_NODE = 'start'.freeze
STOP_NODE = 'end'.freeze
SMALL = 'small'.freeze
LARGE = 'large'.freeze

@pt2 = false

def part1(input)
  map = {}

  input.each do |connection|
    start, stop = connection.split('-')
    map[start] ||= Node.new(metadata: { name: start, size: start.match?(start.upcase) ? LARGE : SMALL })
    map[stop] ||= Node.new(metadata: { name: stop, size: stop.match?(stop.upcase) ? LARGE : SMALL })

    map[start].children << map[stop]
    map[stop].parents << map[start]
  end

  paths = next_node(map[START_NODE], [])
  # puts paths.sort
  puts paths.count
end

def small?(node)
  node.metadata[:size] == SMALL
end

def next_node(node, path, visited = {})
  path = Array.new(path) << node.metadata[:name]
  if node.metadata[:size] == SMALL
    visited[node.metadata[:name]] ||= 0
    visited[node.metadata[:name]] += 1
  end

  # if it's the stop node return the current path
  return path.join(',') if node.metadata[:name] == STOP_NODE

  available_nodes = [].concat(node.children, node.parents).select do |child|
    next false if child.metadata[:name] == START_NODE
    next true if child.metadata[:name] == STOP_NODE

    if @pt2
      # if it's not a small node, or we haven't visited a small node twice yet
      visited_small_twice = visited.find { |_, count| count > 1 }
      visited_child = visited[child.metadata[:name]] || 0

      !small?(child) || (visited_child < 1 || visited_small_twice.nil?)
    else
      # if it's not a small node or if it's a small node and it's not already been visited
      !small?(child) || !path.include?(child.metadata[:name])
    end
  end

  available_nodes.flat_map do |child|
    next_node(child, path, {}.merge(visited))
  end.compact
end

def part2(input)
  @pt2 = true
  part1(input)
end

part1(read_input_lines)
part2(read_input_lines)
