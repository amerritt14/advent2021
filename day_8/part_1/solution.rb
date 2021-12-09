# frozen_string_literal: true

# irb -r ./day_8/part_1/solution.rb
module Day8
  class Part1
    # segment count => digit
    UNIQUE_SEGMENTS = {
      2 => 1,
      4 => 4,
      3 => 7,
      7 => 8
    }.freeze

    def initialize(test: false)
      @test = test
    end

    def perform
      output_values.map do |row|
        row.map { |output| UNIQUE_SEGMENTS.keys.include?(output.length) ? 1 : 0 }.sum
      end.sum
    end

    private

    def output_values
      @output_values ||=
        data.map do |row|
          row.split(" | ").last.split(" ")
        end
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end
  end
end
