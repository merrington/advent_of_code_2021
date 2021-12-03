require '../lib'
include Lib::IO

def part1(input)
  gamma_rate = 0
  epsilon_rate = 0
  bit_string_length = input.size

  bits = input.map(&:chars).transpose
  bits.each_with_index do |bit_string, idx|
    zeros = bit_string.count('0')
    is_zero = zeros > (bit_string_length / 2)
    gamma_rate += (is_zero ? 0 : 1) * (2**(bits.size - idx - 1))
    epsilon_rate += (is_zero ? 1 : 0) * (2**(bits.size - idx - 1))
  end

  gamma_rate * epsilon_rate
end

def part2(rating, input, idx = 0)
  bit_string_length = input.size
  bits = input.map(&:chars).transpose

  zeros = bits[idx].count('0')
  oxygen_bit = zeros > bit_string_length / 2 ? 0 : 1
  co2_bit = zeros <= bit_string_length / 2 ? 0 : 1

  valid_strings = input.select do |bit_string|
    bit_string[idx] == if rating == 'oxygen'
                         oxygen_bit.to_s
                       else
                         co2_bit.to_s
                       end
  end
  return valid_strings[0] if valid_strings.size == 1

  part2(rating, valid_strings, idx += 1)
end
puts part1(read_input_lines)
puts part2('oxygen', read_input_lines).to_i(2) * part2('co2', read_input_lines).to_i(2)
