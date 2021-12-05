require '../lib'
include Lib::IO

def print_table(rows)
  puts '_________|'
  rows.each_with_index do |row, idx|
    puts <<~OUT
      row #{idx.to_s.rjust(4)} | #{row.join}
    OUT
  end
end

def part1(input, part2 = false)
  max_x = 0
  max_y = 0
  rows = []
  overlap_over_2 = 0

  input.each do |line|
    # puts line
    matched = line.match(/(\d+),(\d+) -> (\d+),(\d+)/)
    x1, y1, x2, y2 = *matched[1..4].map(&:to_i)

    # puts 'Updating'

    # grow grid if needed
    if (new_max_x = [x1, x2].max + 1) > max_x
      add_cols = new_max_x - max_x
      rows.each do |row|
        row.fill('.', max_x, add_cols)
      end
      max_x = new_max_x
    end

    if (new_max_y = [y1, y2].max + 1) > max_y
      add_rows = new_max_y - max_y
      add_rows.times do
        rows << Array.new(max_x, '.')
      end
      max_y = new_max_y
    end

    # do the drawing
    if x1 == x2 || y1 == y2
      x1, x2 = [x1, x2].sort # this is gross
      y1, y2 = [y1, y2].sort

      (x1..x2).each do |x|
        (y1..y2).each do |y|
          count = rows[y][x]
          rows[y][x] = case count
                       when '.'
                         1
                       else
                         overlap_over_2 += 1 if count == 1
                         count + 1
                       end
        end
      end
    elsif part2
      # find direction
      x_dir = x2 > x1 ? 1 : -1
      y_dir = y2 > y1 ? 1 : -1
      (0..(x2 - x1).abs).each do |i|
        count = rows[y1 + (i * y_dir)][x1 + (i * x_dir)]
        rows[y1 + (i * y_dir)][x1 + (i * x_dir)] = case count
                                                   when '.'
                                                     1
                                                   else
                                                     overlap_over_2 += 1 if count == 1
                                                     count + 1
                                                   end
      end
    end
    # print_table(rows)
  end

  print_table(rows)
  overlap_over_2
end

def part2(input)
  part1(input, true)
end

puts part1(read_input_lines)
puts part2(read_input_lines)
