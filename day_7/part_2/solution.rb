# frozen_string_literal: true

# irb -r ./day_7/part_2/solution.rb
module Day7
  class Part2
    def initialize(test: false)
      @test = test
    end

    def perform
      (data.min..data.max).map do |destination|
        data.map do |position|
          fuel_summation((position - destination).abs)
        end.sum
      end.min
    end

    private

    def fuel_summation(value)
      return 0 if value < 1

      (1..value).sum
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split(",").map(&:to_i)
    end
  end
end
