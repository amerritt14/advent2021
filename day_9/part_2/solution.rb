# frozen_string_literal: true

# irb -r ./day_9/part_2/solution.rb
module Day9
  Point = Struct.new(:height, :x, :y)
  class Part2
    def initialize(test: false)
      @test = test
    end

    def perform
      low_points = data.flat_map.with_index do |row, y_index|
        row.map.with_index do |height, x_index|
          point = Point.new(height.to_i, x_index, y_index)
          point if lowest_adjacent_point?(point)
        end.compact
      end

      basins = low_points.map do |low|
        build_basin(low, [low]).uniq
      end

      basins.map(&:size).sort.last(3).inject(:*)
    end

    private

    def build_basin(point, basin = [])
      return [] if point.height == 9

      adjacent_points = [find_x_pos(point), find_x_neg(point), find_y_pos(point), find_y_neg(point)]
      adjacent_points = adjacent_points.reject { |p| basin.include?(p) }
      adjacent_points.reject { |p| p.height == 9 }.flat_map do |p|
        [p, build_basin(p, basin << point)]
      end.flatten.compact << point
    end

    def lowest_adjacent_point?(point)
      lower_than_x_pos?(point) &&
        lower_than_x_neg?(point) &&
        lower_than_y_pos?(point) &&
        lower_than_y_neg?(point)
    end

    def find_x_pos(point)
      return Point.new(9, nil, nil) if point.x == data.first.size - 1

      Point.new(data[point.y][point.x + 1], point.x + 1, point.y)
    end

    def find_x_neg(point)
      return Point.new(9, nil, nil) if point.x.zero?

      Point.new(data[point.y][point.x - 1], point.x - 1, point.y)
    end

    def find_y_pos(point)
      return Point.new(9, nil, nil) if point.y == data.size - 1

      Point.new(data[point.y + 1][point.x], point.x, point.y + 1)
    end

    def find_y_neg(point)
      return Point.new(9, nil, nil) if point.y.zero?

      Point.new(data[point.y - 1][point.x], point.x, point.y - 1)
    end

    def lower_than_x_pos?(point)
      point.height < find_x_pos(point).height
    end

    def lower_than_x_neg?(point)
      point.height < find_x_neg(point).height
    end

    def lower_than_y_pos?(point)
      point.height < find_y_pos(point).height
    end

    def lower_than_y_neg?(point)
      point.height < find_y_neg(point).height
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n").map { |row| row.split("").map(&:to_i) }
    end
  end
end
