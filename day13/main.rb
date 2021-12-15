require '../lib'

include Lib::IO

def part1(input)
  grid = {}
  grid_size = [0, 0]
  fold = []

  input.each do |line|
    case line
    when /((\d*),(\d*))/
      grid[Regexp.last_match(1)] = '#'
      grid_size[0] = Regexp.last_match(2).to_i if grid_size[0] < Regexp.last_match(2).to_i
      grid_size[1] = Regexp.last_match(3).to_i if grid_size[1] < Regexp.last_match(3).to_i
    when /.*y=(\d*)/
      fold << [0, Regexp.last_match(1).to_i]
    when /.*x=(\d*)/
      fold << [Regexp.last_match(1).to_i, 0]
    end
  end

  dump_grid(grid)

  fold.each do |fold_point|
    if fold_point[0] == 0 # x is 0 so fold up on y
      ((fold_point[1] + 1)..grid_size[1]).each do |y| # from just after (+1) the fold point to end of sheet
        net_y = y - fold_point[1]
        (0..grid_size[0]).each do |x| # iterate over all x
          next unless grid["#{x},#{y}"] == '#' # skip if x,y is not a point

          # mirror it
          grid["#{x},#{fold_point[1] - net_y}"] = '#'
          # delete it
          grid.delete("#{x},#{y}")
        end
      end
    else # x is not 0 so fold left on x
      (0..grid_size[1]).each do |y|
        ((fold_point[0] + 1)..grid_size[0]).each do |x|
          next unless grid["#{x},#{y}"] == '#'

          net_x = x - fold_point[0]

          grid["#{fold_point[0] - net_x},#{y}"] = '#'
          grid.delete("#{x},#{y}")
        end
      end
    end

    dump_grid(grid)
    puts grid.keys.count
  end
end

def dump_grid(grid)
  arr = []
  grid.keys.each do |key|
    x, y = key.split(',').map(&:to_i)
    # grow the array to the right size
    (arr.length..y).each { arr << Array.new(arr[0]&.size || x, '.') }
    arr.each do |row|
      next if row.length >= x

      (row.length..x).each { row << '.' }
    end

    arr[y][x] = grid[key]
  end

  arr.each do |row|
    puts row.join
  end
  puts '------'
end

part1(read_input_lines)
