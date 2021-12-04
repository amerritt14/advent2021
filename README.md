# Advent of Code 2021

## Usage

Clone the repo and cd into the directory.

### Using the runner
Load the runner into an irb instance
```bash
irb -r ./runner.rb
```

### Using Pry
Install the pry gem, then load the runner into the pry instance.
```bash
gem install pry
pry -r ./runner.rb
```

From irb you can now call any of the day/part combinations with their test inputs
```ruby
$irb> runner = Runner.new(day: 1, part: 1, test: true)
$irb> runner.perform
 ==> 7
```

If you make changes to the solution.rb file that you're working on, you can reload it without exiting the IRB instance.

```ruby
$irb> runner.reload
  ==> true
```
