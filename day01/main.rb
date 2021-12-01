INPUTS = {
    sample: 'sample_in.txt',
    default: 'in.txt',
}

def input(path)
    File.read(path).split
end


def part1(input)
    initial = {
        count: 0,
        prev: nil
    }
    input.reduce(initial) do |memo, obj|
        prev = memo[:prev]
        memo[:prev] = obj.to_i

        next memo if !prev

        memo[:count] += 1 if prev < obj.to_i
        memo
    end
end

def part2(input)
    initial = {
        list: [],
        acc: [],
    }
    summed = input.reduce(initial) do |memo, obj|
        # puts obj
        memo[:acc] << obj.to_i
        next memo unless memo[:acc].size % 3 == 0

        memo[:list] << memo[:acc].sum
        memo[:acc].shift

        memo
    end

    part1(summed[:list])
end

in_file = INPUTS[ARGV[0]&.to_sym || :default]

puts part1(input(in_file))
puts part2(input(in_file))