# frozen_string_literal: true

# irb -r ./runner.rb
# Runner.new(day: 1, part: 1, test: true).perform
class Runner
  attr_writer :test

  def initialize(day:, part:, test: false)
    @day = day
    @part = part
    @test = test
    reload
  end

  def perform(args = {})
    klass(args).perform
  end

  # reload changes to the solution file without exiting IRB.
  def reload
    load "day_#{@day}/part_#{@part}/solution.rb"
  end

  def klass(args = {})
    "Day#{@day}::Part#{@part}".constantize.new(**args.merge(test: @test))
  end
end

# build the constantize method.
class String
  def constantize
    split('::').inject(Module) { |acc, val| acc.const_get(val) }
  end
end
