# frozen_string_literal: true

# irb -r ./day_10/part_2/solution.rb
module Day10
  class Part2
    def initialize(test: false)
      @test = test
    end

    TAG_KEY = {
      "(" => ")",
      "[" => "]",
      "{" => "}",
      "<" => ">"
    }.freeze

    VALUES = {
      ")" => 1,
      "]" => 2,
      "}" => 3,
      ">" => 4,
    }

    def perform
      suggestions = data.map do |row|
        @open_chunks = []
        invalid_char = find_invalid_char(row)
        autocomplete unless invalid_char
      end.compact
      scores = suggestions.map { |row| score(row) }.sort
      median(scores)
    end

    private

    # Niave implementation assuming the array count will always be odd, and pre-sorted.
    def median(array)
      center = (array.length - 1) / 2.0
      array[center]
    end

    def score(row)
      score = 0
      row.each do |char|
        score = (5 * score) + VALUES[char]
      end
      score
    end

    def autocomplete
      @open_chunks.reverse.map do |tag|
        TAG_KEY[tag]
      end
    end

    def find_invalid_char(row)
      row.chars.find do |tag|
        handle_opening_tag(tag) if TAG_KEY.keys.include?(tag)

        invalid?(tag)
      end
    end

    def handle_opening_tag(tag)
      @open_chunks << tag
    end

    def invalid?(tag)
      return false if tag == @open_chunks.last

      TAG_KEY[@open_chunks.pop] != tag
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).split("\n")
    end
  end
end
