# frozen_string_literal: true

# irb -r ./day_2/part_1/solution.rb
module Day2
  class Part2
    class Submarine
      attr_accessor :horizontal_position, :depth, :aim

      DIRECTIONAL_SIGNS = {
        'down' => '',
        'up' => '-'
      }.freeze

      def initialize
        @horizontal_position = 0
        @depth = 0
        @aim = 0
      end

      def move(direction, distance)
        if direction == 'forward'
          move_forward(distance.to_i)
        else
          adjust_aim("#{DIRECTIONAL_SIGNS[direction]}#{distance}".to_i)
        end
      end

      private

      def move_forward(distance)
        self.horizontal_position += distance
        self.depth += distance * aim
      end

      def adjust_aim(value)
        self.aim += value
      end
    end
    # End of Submarine class

    attr_reader :sub

    def initialize(test: false)
      @test = test
      @sub = Submarine.new
    end

    def perform
      data.each do |row|
        sub.move(*row.split(' '))
      end

      sub.horizontal_position * sub.depth
    end

    private

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end
  end
end
