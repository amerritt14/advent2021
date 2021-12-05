# frozen_string_literal: true

# irb -r ./day_4/part_2/solution.rb
module Day4
  class Part2
    def initialize(test: false)
      @test = test
      @turn = 0
      @bingo = []
    end

    def perform
      until @bingo.size == cards.size
        @turn += 1
        call_number_on_turn
      end
      (last_winning_card.flatten - called_numbers).sum * called_numbers.last
    end

    private

    def last_winning_card
      cards[@bingo.last]
    end

    def numbers
      @numbers ||= data.first.split(",").map(&:to_i)
    end

    def call_number_on_turn
      @bingo = @bingo | horizontal_bingo | vertical_bingo
    end

    def called_numbers
      numbers[0..@turn]
    end

    def horizontal_bingo
      cards.map do |card_number, card_values|
        card_number if card_values.any? { |row| (row - called_numbers).empty? }
      end.compact
    end

    def vertical_bingo
      cards.map do |card_number, card_values|
        card_number if card_values.transpose.any? { |row| (row - called_numbers).empty? }
      end.compact
    end

    def card(num)
      card_start = ((num - 1) * 6) + 2
      card_end = card_start + 4
      data[card_start..card_end].map { |row| row.split(" ").compact.map(&:to_i) }
    end

    def cards
      @cards ||=
        (1..card_count).map do |i|
          [i, card(i)]
        end.to_h
    end

    def card_count
      data[1..-1].compact.length/6
    end

    def data
      return @data unless @data.nil?

      file_name = (@test == true ? 'test_input.txt' : 'input.txt')
      @data = File.read(File.expand_path("../../#{file_name}", __FILE__)).gsub('  ', ' ').split("\n")
    end
  end
end
