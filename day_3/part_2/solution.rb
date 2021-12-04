# frozen_string_literal: true

# irb -r ./day_3/part_2/solution.rb
module Day3
  class Part2
    def initialize(test: false)
      @test = test
    end

    def perform
      puts "Oxygen Generator Rating: #{oxygen_generator_rating}"
      puts "CO2 Scrubber Rating: #{co2_scrubber_rating}"

      oxygen_generator_rating * co2_scrubber_rating
    end

    private

    def oxygen_generator_criteria(data_set)
      data_set.map do |row|
        mean(row).round
      end.join
    end

    def oxygen_generator_binary_string
      values = data
      oxygen_generator_criteria(transposed_data).length.times do |i|
        next if values.count == 1

        new_oxygen_generator_criteria = oxygen_generator_criteria(transposed_data(values))
        values = values.select { |value| value[i].to_i == new_oxygen_generator_criteria[i].to_i }
      end
      values.first
    end

    def co2_scrubber_criteria(data_set)
      invert_bits(oxygen_generator_criteria(data_set))
    end

    def co2_scrubber_binary_string
      values = data
      co2_scrubber_criteria(transposed_data).length.times do |i|
        next if values.count == 1

        new_co2_scrubber_criteria = co2_scrubber_criteria(transposed_data(values))
        values = values.select { |value| value[i].to_i == new_co2_scrubber_criteria[i].to_i }
      end
      values.first
    end

    def invert_bits(string)
      string.gsub("1", "x").gsub("0", "1").gsub("x", "0")
    end

    def oxygen_generator_rating
      oxygen_generator_binary_string.to_i(2)
    end

    def co2_scrubber_rating
      co2_scrubber_binary_string.to_i(2)
    end

    def mean(array)
      array.inject(0.0) { |sum, el| sum + el } / array.size
    end

    def transposed_data(data_set = data)
      data_set.map { |el| el.split('') }.transpose.map do |row|
        row.map(&:to_i)
      end
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end
  end
end
