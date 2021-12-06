# frozen_string_literal: true

module Day6
  class LanternFish
    attr_reader :birth_timer

    def initialize(starting_timer = 8)
      @cycle = (0..6).to_a.reverse.cycle
      @wait_timer = [(starting_timer - 6), 0].max

      if starting_timer <= 6
        @birth_timer = nil
        while birth_timer != starting_timer
          grow_older
        end
      end
    end

    def days_til_birth
      @wait_timer.to_i + (@birth_timer || 6)
    end

    def grow_older
      if @wait_timer <= 1
        @birth_timer = @cycle.next
      else
        @wait_timer -= 1
      end
    end
  end
end
