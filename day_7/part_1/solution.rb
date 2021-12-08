# frozen_string_literal: true

# irb -r ./day_7/part_1/solution.rb
module Day7
  class Part1
    def initialize(test: false)
      @test = test
    end

    def perform
      (data.min..data.max).map do |destination|
        data.map do |position|
          (position - destination).abs
        end.sum
      end.min
    end

    private

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split(",").map(&:to_i)
    end
  end
end
