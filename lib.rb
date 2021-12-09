require 'pry'

module Lib
  module IO
    def read_input_lines
      path = "#{ARGV[0] || 'in'}.txt"
      File.readlines(path, chomp: true)
    end
  end
end
