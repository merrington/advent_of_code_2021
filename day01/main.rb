INPUTS = {
  sample: 'sample_in.txt',
  default: 'in.txt',
}.freeze

def input(path)
  File.read(path).split
end

def part1(input)
  initial = {
    count: 0,
    prev: nil,
  }
  input.each_with_object(initial) do |obj, memo|
    prev = memo[:prev]
    memo[:prev] = obj.to_i

    next memo unless prev

    memo[:count] += 1 if prev < obj.to_i
  end
end

def part2(input)
  initial = {
    list: [],
    acc: [],
  }
  summed = input.each_with_object(initial) do |obj, memo|
    memo[:acc] << obj.to_i
    next memo unless (memo[:acc].size % 3).zero?

    memo[:list] << memo[:acc].sum
    memo[:acc].shift
  end

  part1(summed[:list])
end

in_file = INPUTS[ARGV[0]&.to_sym || :default]

puts part1(input(in_file))
puts part2(input(in_file))
