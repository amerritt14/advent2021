# frozen_string_literal: true

# irb -r ./day_1/part_2/solution.rb
module Day1
  class Part2
    def initialize(test: false)
      @test = test
      @previous = nil
      @sample1 = nil
      @sample2 = nil
      @sample3 = nil
      @count = 0
    end

    def perform
      data.each do |sample|
        sum = shift_sum(sample)
        @count += compare_sums(sum) if @previous

        @previous = sum
      end

      @count
    end

    private

    def data
      return @data unless @data.nil?

      file_name = (@test === true ? "test_input.txt" : "input.txt")
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n").map(&:to_i)
    end

    def compare_sums(current_sum)
      @previous < current_sum ? 1 : 0
    end

    # returns nil until all 3 values are filled
    def shift_sum(new_sample)
      @sample3 = @sample2
      @sample2 = @sample1
      @sample1 = new_sample

      [@sample1, @sample2, @sample3].sum if @sample1 && @sample2 && @sample3
    end
  end
end
