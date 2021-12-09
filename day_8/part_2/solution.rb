# frozen_string_literal: true

# irb -r ./day_8/part_2/solution.rb
module Day8
  class Part2

    # segment count => digit
    UNIQUE_SEGMENTS = {
      2 => 1,
      4 => 4,
      3 => 7,
      7 => 8
    }.freeze

    def initialize(test: false)
      @test = test
    end

    def perform
      output = data.map do |row|
        @key = {}
        @number_codes = number_codes(row)
        populate_key
        number = output_values(row)
        n = number.split(" ").map do |digit|
          digit_translator(digit)
        end.join
        puts "#{number}: #{n}"
        n
      end
      output.map(&:to_i).sum
    end

    private

    def populate_key
      # Set the uniq values based on length
      UNIQUE_SEGMENTS.each do |length, value|
        @key[value] = @number_codes.delete(@number_codes.find { |code| code.length == length })
      end
      find_three
      find_five
      find_nine
      find_two
      find_six
      find_zero
    end

    def find_two
      two = @number_codes.find do |code|
        # 2 is the only 5 digit code left at this point
        code.length == 5
      end
      @key[2] = @number_codes.delete(two)
    end

    def find_three
      three = @number_codes.find do |code|
        parts = code.chars
        parts.length == 5 && parts & @key[7].chars == @key[7].chars
      end
      @key[3] = @number_codes.delete(three)
    end

    def find_five
      five = @number_codes.find do |code|
        code.length == 5 &&
          @number_codes.any? do |c|
            c.length == 6 &&
              (c.chars & code.chars).join == code
          end
      end
      @key[5] = @number_codes.delete(five)
    end

    def find_nine
      matches = @number_codes.select do |code|
        code.length == 6 &&
          (code.chars & @key[5].chars).join == @key[5]
      end
      nine = matches.find{ |code| (code.chars & @key[3].chars).join == @key[3] }
      @key[9] = @number_codes.delete(nine)
    end

    def find_six
      middle_line = @key[2].chars & @key[4].chars & @key[5].chars & @key[9].chars
      six = @number_codes.find { |code| code.include?(middle_line.first) }
      @key[6] = @number_codes.delete(six)
    end

    def find_zero
      # last item
      @key[0] = @number_codes.first
    end

    def digit_translator(digit)
      @key.invert[digit.chars.sort.join].to_s
    end

    def output_values(row)
      row.split(" | ").last
    end

    def number_codes(row)
      row.split(" | ").first.split(" ").compact.map { |n| n.chars.sort.join }
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end
  end
end
