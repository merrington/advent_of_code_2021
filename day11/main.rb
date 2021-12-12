require '../lib'

include Lib::IO

@energy_levels = {}

def part1(input)
  steps = 100
  flashes = 0

  input.each_with_index do |row, y|
    row.each_char.with_index do |char, x|
      @energy_levels[[x, y]] = char.to_i
    end
  end

  dump_map(@energy_levels)
  (1..steps).each do |step|
    flashed = {}
    @energy_levels.each_key { |pos| @energy_levels[pos] += 1 }
    @energy_levels.each_key.map do |pos|
      next unless @energy_levels[pos] > 9

      result = perform_flashes(flashed, pos)
      result[:flashed].each_key { |f| @energy_levels[f] = 0 }
      flashes += result[:flashes]
      flashed = result[:flashed]
    end
    flashed.each_key { |pos| @energy_levels[pos] = 0 }
    puts "Step #{step} - #{flashes} flashes"
    # dump_map(@energy_levels) if step < 10 || (step % (steps / 10) == 0)
  end

  puts flashes
end

def part2(input)
  steps = 0
  flashes = 0

  input.each_with_index do |row, y|
    row.each_char.with_index do |char, x|
      @energy_levels[[x, y]] = char.to_i
    end
  end

  dump_map(@energy_levels)
  synchronized = false
  until synchronized
    flashed = {}
    @energy_levels.each_key { |pos| @energy_levels[pos] += 1 }
    @energy_levels.each_key.map do |pos|
      next unless @energy_levels[pos] > 9

      result = perform_flashes(flashed, pos)
      result[:flashed].each_key { |flashed| @energy_levels[flashed] = 0 }
      flashes += result[:flashes]
      flashed = result[:flashed]
    end
    steps += 1
    synchronized = true if flashed.keys.size == @energy_levels.keys.size
  end
  puts steps
end

def perform_flashes(flashed, pos)
  flashes = 0
  size = 10

  if @energy_levels[pos] > 9 && !flashed[pos]
    flashes += 1
    flashed[pos] = true
    [-1, 0, 1].each do |x|
      [-1, 0, 1].each do |y|
        next if x == 0 && y == 0
        next if pos[0] + x < 0 || pos[0] + x >= size
        next if pos[1] + y < 0 || pos[1] + y >= size

        @energy_levels[[pos[0] + x, pos[1] + y]] += 1 unless flashed[[pos[0] + x, pos[1] + y]]
        next unless @energy_levels[[pos[0] + x, pos[1] + y]] > 9

        result = perform_flashes(flashed, [pos[0] + x, pos[1] + y])
        flashed = result[:flashed]
        flashes += result[:flashes]
      end
    end
  end

  {
    flashed: flashed,
    flashes: flashes,
  }
end

def dump_map(map)
  array = []
  map.each_key do |pos|
    array[pos[1]] ||= []
    array[pos[1]][pos[0]] = map[pos]
  end
  puts array.map { |row| row.join }.join("\n")
  puts '---'
end

part1(read_input_lines)

part2(read_input_lines)
