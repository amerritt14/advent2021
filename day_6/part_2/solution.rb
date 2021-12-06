# frozen_string_literal: true

# irb -r ./day_6/part_2/solution.rb
module Day6
  class Part2
    DAYS = 256

    def initialize(test: false)
      @test = test
      @school = []
    end

    def perform
      seed_school
      initialize_mapping
      process_days

      @mapping.values.sum
    end

    private

    def initialize_mapping
      @mapping = empty_mapping
      @school.each do |fish_type|
        @mapping[fish_type] += 1
      end
    end

    def process_days
      DAYS.times do
        @mapping = process_day
      end
    end

    def process_day
      daily_mapping = empty_mapping

      @mapping.each do |fish_type, count|
        if fish_type.zero?
          daily_mapping[6] += count
          daily_mapping[8] += count
        else
          daily_mapping[fish_type - 1] += count
        end
      end

      daily_mapping
    end

    def empty_mapping
      h = {}
      (0..8).each { |i| h[i] = 0 }
      h
    end

    def seed_school
      @school = data.map(&:to_i)
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split(",")
    end
  end
end
