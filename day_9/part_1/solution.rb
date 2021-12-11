# frozen_string_literal: true

# irb -r ./day_9/part_1/solution.rb
module Day9
  Point = Struct.new(:height, :x, :y)
  class Part1
    def initialize(test: false)
      @test = test
    end

    def perform
      low_points = data.flat_map.with_index do |row, y_index|
        row.select.with_index do |height, x_index|
          lowest_adjacent_point?(Point.new(height.to_i, x_index, y_index))
        end
      end
      low_points.sum + low_points.size
    end

    private

    def lowest_adjacent_point?(point)
      lower_than_x_pos?(point) &&
        lower_than_x_neg?(point) &&
        lower_than_y_pos?(point) &&
        lower_than_y_neg?(point)
    end

    def lower_than_x_pos?(point)
      return true if point.x == data.first.size - 1

      point.height < data[point.y][point.x + 1]
    end

    def lower_than_x_neg?(point)
      return true if point.x.zero?

      point.height < data[point.y][point.x - 1]
    end

    def lower_than_y_pos?(point)
      return true if point.y == data.size - 1

      point.height < data[point.y + 1][point.x]
    end

    def lower_than_y_neg?(point)
      return true if point.y.zero?

      point.height < data[point.y - 1][point.x]
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n").map { |row| row.split("").map(&:to_i) }
    end
  end
end
