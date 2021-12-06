# frozen_string_literal: true

# irb -r ./day_6/part_1/solution.rb
module Day6
  class Part1
    require_relative '../lantern_fish'

    DAYS = 256

    def initialize(test: false)
      @test = test
      @school = []
    end

    def perform
      seed_school
      DAYS.times do |i|
        new_fish = []
        @school.each { |fish|  new_fish.push(Day6::LanternFish.new) if fish.birth_timer == 0 }
        @school.each(&:grow_older)
        @school += new_fish
        # puts "After #{i + 1} day(s): #{@school.map(&:days_til_birth)}"
      end

      @school.size
    end

    private

    def seed_school
      data.each do |age|
        @school.push(Day6::LanternFish.new(age.to_i))
      end
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split(",")
    end
  end
end
