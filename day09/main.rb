require '../lib'

include Lib::IO

def part1(input)
  input = input.map do |line|
    line.chars.map(&:to_i)
  end

  risk_level = 0

  input.each_with_index do |row, y|
    row.each_with_index do |height, x|
      lowest = [[-1, 0], [0, 1], [1, 0], [0, -1]].all? do |(dy, dx)|
        next true if (y + dy).negative? || (x + dx).negative?
        next true if (y + dy) >= input.size || (x + dx) >= row.size
        next true unless input[y + dy] && input[y + dy][x + dx]

        height < input[y + dy][x + dx]
      end

      next unless lowest

      # put the current position, value and risk_level
      # puts "#{x},#{y} #{height} #{risk_level}"
      risk_level += (height + 1)
    end
  end

  puts risk_level
end

def part2(input)
  visited = {}
  basin = {}

  input = input.map do |line|
    line.chars.map(&:to_i)
  end

  input.each_with_index do |row, y|
    row.each_with_index do |_height, x|
      point = [y, x]
      next if visited[point]
      next if input[y][x] == 9

      # start of the next basin
      result = expand_basin(y, x, input, 0, visited)
      basin[point] = result[:basin]
      visited = result[:visited]
    end
  end

  puts basin.values.max(3).reduce(&:*)
end

def expand_basin(y, x, input, basin, visited)
  return { basin: basin, visited: visited } if visited[[y, x]]

  visited[[y, x]] = true
  return { basin: basin, visited: visited } if y.negative? || y >= input.size
  return { basin: basin, visited: visited } if x.negative? || x >= input[y].size
  return { basin: basin, visited: visited } if input[y][x] == 9

  basin += 1

  [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |(dy, dx)|
    result = expand_basin(y + dy, x + dx, input, basin, visited)
    basin = result[:basin]
    visited = result[:visited]
  end

  { basin: basin, visited: visited }
end

part1(read_input_lines)
part2(read_input_lines)
