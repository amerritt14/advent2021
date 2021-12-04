# frozen_string_literal: true

# irb -r ./day_3/part_1/solution.rb
module Day3
  class Part1
    def initialize(test: false)
      @test = test
    end

    def perform
      puts "Gamma Rate: #{gamma_rate}"
      puts "Epsilon Rate: #{epsilon_rate}"

      gamma_rate * epsilon_rate
    end

    private

    def gamma_binary_string
      @gamma_binary_string ||=
        transposed_data.map do |row|
          mean(row).round
        end.join
    end

    def epsilon_binary_string
      @epsilon_binary_string ||=
        invert_bits(gamma_binary_string)
    end

    def invert_bits(string)
      string.gsub("1", "x").gsub("0", "1").gsub("x", "0")
    end

    def gamma_rate
      gamma_binary_string.to_i(2)
    end

    def epsilon_rate
      epsilon_binary_string.to_i(2)
    end

    def mean(array)
      array.inject(0.0) { |sum, el| sum + el } / array.size
    end

    def transposed_data
      data.map { |el| el.split('') }.transpose.map do |row|
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
