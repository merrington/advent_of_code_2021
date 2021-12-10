require '../lib'

include Lib::IO

def part1(input)
  pairs = {
    '{' => '}',
    '[' => ']',
    '(' => ')',
    '<' => '>',
  }
  point_values = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25_137,
  }
  part2_point_values = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4,
  }
  points = 0
  part2_points = []

  input.each do |line|
    catch :unexpected do
      stack = []
      line.chars.each do |char|
        if pairs.key?(char)
          stack << pairs[char]
        elsif stack.pop != char
          points += point_values[char]
          throw :unexpected
        end
      end

      part2_points << stack.reverse.reduce(0) do |memo, char|
        (memo * 5) + part2_point_values[char]
      end
    end
  end

  puts points
  puts part2_points.sort[part2_points.size / 2]
end

part1(read_input_lines)
