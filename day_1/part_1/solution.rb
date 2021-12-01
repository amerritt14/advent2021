# frozen_string_literal: true

# irb -r ./day_1/part_1/solution.rb
module Day1
  class Part1
    def initialize(test: false)
      @test = test
      @previous = nil
      @count = 0
    end

    def perform
      data.each do |sample|
        sample = sample.to_i
        @count += compare_samples(@previous, sample) if @previous

        @previous = sample
      end

      @count
    end

    private

    def data
      return @data unless @data.nil?

      file_name = (@test === true ? "test_input.txt" : "input.txt")
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end

    def compare_samples(previous_sample, current_sample)
      previous_sample > current_sample ? 0 : 1
    end
  end
end
