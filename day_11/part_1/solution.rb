# frozen_string_literal: true

# irb -r ./day_11/part_1/solution.rb
module Day11
  class Part1
    STEPS = 100

    attr_reader :field

    def initialize(test: false)
      @test = test
      @flash_count = 0
    end

    def perform
      seed_field
      (1..STEPS).map do |_step|
        add_energy_to_all
        flashes = flash([]).uniq
        flashes.each(&:reset_energy)
        flashes.size
      end.sum
    end

    private

    def flash(previously_flashed)
      ready_to_flash = field.flatten.select { |oct| oct.energy > 9 } - previously_flashed
      return previously_flashed if ready_to_flash.empty?

      # may need to uniq this
      ready_to_flash.flat_map(&:adjacent).each do |point|
        @field[point.y][point.x].add_energy
      end

      flash(previously_flashed + ready_to_flash)
    end

    def add_energy_to_all
      field.flatten.each(&:add_energy)
    end

    def seed_field
      @field = data.map.with_index do |row, y|
        row.chars.map(&:to_i).map.with_index do |energy, x|
          Octopus.new(Point.new(x, y), energy)
        end
      end
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end
  end

  Point = Struct.new(:x, :y)

  class Octopus
    attr_reader :position, :energy

    def initialize(position, energy)
      @position = position
      @energy = energy
      adjacent
    end

    def add_energy
      @energy += 1
    end

    def reset_energy
      @energy = 0
    end

    def adjacent
      @adjacent ||=
        limit_range(position.y).map do |y|
          limit_range(position.x).map { |x| Point.new(x, y) }
        end.flatten
    end

    private

    # 10 x 10 mapping, so x and y have hard limits of 0 - 9
    def limit_range(num)
      ([0, num - 1].max..[9, num + 1].min)
    end
  end
end
