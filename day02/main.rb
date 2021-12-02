require '../lib'
include Lib::IO

def part1(input)
  location = [0, 0]
  input.each do |command|
    direction, distance = command.split
    distance = distance.to_i

    case direction
    when 'forward'
      location[0] += distance
    when 'down'
      location[1] += distance
    when 'up'
      location[1] -= distance
    end
  end
  location
end

def part2(input)
  aim = 0
  location = [0, 0]
  input.each do |command|
    direction, distance = command.split
    distance = distance.to_i

    case direction
    when 'forward'
      location[0] += distance
      location[1] += aim * distance
    when 'down'
      aim -= distance
    when 'up'
      aim += distance
    end
  end

  [aim, location]
end

p1 = part1(read_input_lines)
puts p1, (p1[0] * p1[1])

p2 = part2(read_input_lines)
puts p2, (p2[1][0] * p2[1][1]).abs
