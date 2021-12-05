# frozen_string_literal: true

# irb -r ./day_5/part_2/solution.rb
module Day5
  class Part2
    def initialize(test: false)
      @test = test
      @vent_map = []
    end

    def perform
      map_vents
      count_overlaps
    end

    private

    def map_vents
      vent_coordinates.each do |vent_line|
        vent_line.each do |x, y|
          @vent_map[x] ||= [] # in case the row doesn't yet exist
          @vent_map[x][y] = @vent_map[x][y].to_i + 1
        end
      end
    end

    def count_overlaps
      @vent_map.flatten.compact.select { |count| count > 1 }.size
    end

    # Turns the start/stop input into a list of x,y coordinates for each vent line
    def vent_coordinates
      @vent_coordinates ||=
        data.map { |row| row.split(" -> ") }.map do |start, stop|
          x1, y1 = start.split(",").map(&:to_i)
          x2, y2 = stop.split(",").map(&:to_i)
          if x1 == x2 # horizontal lines
            horizontal_coordinates(y1, y2, x1)
          elsif y1 == y2 # vertical lines
            vertical_coordinates(x1, x2, y1)
          else # diagonal lines
            diagonal_coordinates(x1, x2, y1, y2)
          end
        end.reject(&:empty?)
    end

    def horizontal_coordinates(y1, y2, x)
      ([y1, y2].min..[y1, y2].max).map { |y| [x, y] }
    end

    def vertical_coordinates(x1, x2, y)
      ([x1, x2].min..[x1, x2].max).map { |x| [x, y] }
    end

    def diagonal_coordinates(x1, x2, y1, y2)
      x_length = (x1 - x2)
      y_length = (y1 - y2)
      length = [x_length.abs, y_length.abs].max

      x_dir = x_length.positive? ? 1 : -1
      y_dir = y_length.positive? ? 1 : -1

      (0..length).map do |count|
        [x2 + (x_dir * count), y2 + (y_dir * count)]
      end
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).gsub('  ', ' ').split("\n")
    end
  end
end
