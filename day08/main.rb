require '../lib'

include Lib::IO

def part1(input)
  count = input.map do |line|
    numbers = line.split('|')[1].split
    numbers.count { |n| [2, 4, 3, 7].include?(n.length) }
  end
  puts count.sum
end

def part2(input)
  final_num = input.map do |line|
    map = {}

    input, output = line.split('|').map(&:split)

    # find the easy ones - 1, 4, 7, 8
    one = input.find { |n| n.length == 2 }
    four = input.find { |n| n.length == 4 }
    seven = input.find { |n| n.length == 3 }
    eight = input.find { |n| n.length == 7 }

    # do the rest
    six = input.find { |n| n.length == 6 && n.chars.difference(one.chars).length == 5 }
    five = input.find { |n| n.length == 5 && n.chars.difference(six.chars).length.zero? }
    two = input.find { |n| n.length == 5 && n.chars.difference(five.chars).length == 2 }
    three = input.find { |n| n.length == 5 && n.chars.difference(one.chars).length == 3 }
    nine = input.find { |n| n.length == 6 && n.chars.difference(four.chars).length == 2 }
    zero = input.find do |n|
      n.length == 6 && n.chars.difference(nine.chars).length == 1 && n.chars.difference(six.chars).length == 1
    end

    map[one.chars.sort.join] = 1
    map[two.chars.sort.join] = 2
    map[three.chars.sort.join] = 3
    map[four.chars.sort.join] = 4
    map[five.chars.sort.join] = 5
    map[six.chars.sort.join] = 6
    map[seven.chars.sort.join] = 7
    map[eight.chars.sort.join] = 8
    map[nine.chars.sort.join] = 9
    map[zero.chars.sort.join] = 0

    puts map
    (output.map do |numbers|
      map[numbers.chars.sort.join]
    end).join.to_i
  end

  puts final_num.sum
end

part1(read_input_lines)
part2(read_input_lines)
