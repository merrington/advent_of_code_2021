require '../lib'

include Lib::IO

def part1(input, days = 80)
  fish_on_day = Array.new(9, 0)

  input.first.split(',').each do |day|
    day = day.to_i
    fish_on_day[day] += 1
  end

  # dump_fish(fish_on_day)

  days.times do
    increase_day!(fish_on_day)
  end

  dump_fish(fish_on_day)
  puts fish_on_day.sum
end

def part2(input)
  part1(input, 256)
end

def dump_fish(fish)
  fish.each_with_index do |fysh, idx|
    puts "#{idx.to_s.rjust(3, '0')}: #{fysh}"
  end
end

def increase_day!(fish)
  # shift the array, what pops off gets added to day 6 + the same amount gets added to day 8
  reproduce = fish.shift
  fish[6] += reproduce
  fish[8] = reproduce
end

part1(read_input_lines)
part2(read_input_lines)
