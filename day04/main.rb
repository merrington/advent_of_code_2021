require '../lib'
include Lib::IO

class Board
  attr_accessor :all_num, :grid

  def initialize(rows)
    self.grid = []

    self.all_num = rows.flat_map(&:split)
    rows.each_with_index do |row, idx|
      grid[idx] = row.split
    end
  end

  def mark_number(num)
    idx = all_num.find_index(num)
    return false unless idx

    all_num[idx] = nil
    row = (idx / 5).floor
    col = idx % 5
    grid[row][col] = nil
    true
  end

  def winner?
    row_winner = grid.find do |row|
      row.compact.empty?
    end
    col_winner = grid.transpose.find do |col|
      col.compact.empty?
    end

    row_winner || col_winner
  end

  def to_s
    grid.map(&:to_s)
  end
end

def setup(input)
  @called_numbers = input.shift.split(',')
  @boards = []

  # build the boards
  input.reduce([]) do |memo, row|
    # first line is filler, so `memo` should be an empty string
    next memo if row.empty?

    memo << row
    next memo unless memo.size == 5

    @boards << Board.new(memo)
    []
  end
end

def part1(input)
  setup(input)

  @called_numbers.find do |called_number|
    winner = @boards.find do |board|
      next false unless board.mark_number(called_number)
      next false unless board.winner?

      true
    end

    next if winner.nil?

    return 'winner', called_number.to_i * winner.all_num.map(&:to_i).sum
  end
end

def part2(input)
  setup(input)

  @called_numbers.find do |called_number|
    winners = @boards.select do |board|
      next false unless board.mark_number(called_number)

      board.winner?
    end

    if @boards.size > 1
      winners.each do |winner|
        @boards.delete(winner)
      end
      next
    end

    return 'winner', called_number.to_i * winners[0].all_num.map(&:to_i).sum if @boards.size == 1
  end
end

puts part1(read_input_lines)
puts part2(read_input_lines)
