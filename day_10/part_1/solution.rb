# frozen_string_literal: true

# irb -r ./day_10/part_1/solution.rb
module Day10
  class Part1
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
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137,
    }

    def perform
      illegal = data.map do |row|
        @open_chunks = []
        row.chars.find do |tag|
          handle_opening_tag(tag) if TAG_KEY.keys.include?(tag)

          invalid?(tag)
        end
      end.compact

      illegal.map{|c| VALUES[c]}.sum
    end

    private

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
