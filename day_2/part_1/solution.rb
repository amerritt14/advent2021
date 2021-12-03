# frozen_string_literal: true

# irb -r ./day_2/part_1/solution.rb
module Day2
  class Part1
    DIRECTIONAL_SIGNS = {
      "forward"  => "",
      "down"     => "",
      "up"       => "-",
    }.freeze

    def initialize(test: false)
      @test = test
    end

    def perform
      sort_data
      puts "Horizontal distance: #{horizontal_sum}"
      puts "depth distance: #{depth_sum}"
      puts "Product: #{horizontal_sum * depth_sum}"

      horizontal_sum * depth_sum
    end

    private

    def sort_data
      @horizontal_data, @depth_data =
        data.
        map { |row| row.split(' ') }.
        partition { |direction, _distance| direction == "forward" }
    end

    def horizontal_sum
      translate_data(@horizontal_data).sum
    end

    def depth_sum
      translate_data(@depth_data).sum
    end

    def data
      return @data unless @data.nil?

      file_name = (@test === true ? "test_input.txt" : "input.txt")
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end

    def translate_data(subset)
      subset.map { |direction, distance| "#{DIRECTIONAL_SIGNS[direction]}#{distance}".to_i }
    end
  end
end
