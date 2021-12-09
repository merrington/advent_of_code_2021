require '../lib'

include Lib::IO

def part1(input, pt2 = false)
  distances = {}
  min = 0
  max = 0
  input[0].split(',').each do |position|
    position = position.to_i
    min = position if position < min
    max = position if position > max

    distances[position] = distances[position] ? distances[position] + 1 : 1
  end

  result = (min..max).reduce({}) do |memo, distance|
    fuel = distances.keys.map do |location|
      if pt2
        distances[location] * (1..(distance - location).abs).sum
      else
        distances[location] * (distance - location).abs
      end
    end.sum

    next memo unless memo[:fuel].nil? || fuel < memo[:fuel]

    next {
      distance: distance,
      fuel: fuel,
    }
  end

  puts "distance: #{result[:distance]}\nfuel: #{result[:fuel]}"
end

def part2(input)
  part1(input, true)
end

part1(read_input_lines)
part2(read_input_lines)
