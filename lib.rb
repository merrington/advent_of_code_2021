module Lib
  module IO
    INPUTS = {
      sample: 'sample_in.txt',
      default: 'in.txt',
    }.freeze

    def read_input_lines
      path = INPUTS[ARGV[0]&.to_sym || :default]
      File.readlines(path)
    end
  end
end
