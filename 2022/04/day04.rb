# frozen_string_literal: true

# Take an input of elf assignment pairs and find the overlaps
class CleanUp
  attr_reader :input

  def initialize(file)
    @input = File.open(file).readlines
  end

  private

  def range_creator(pair)
    ranges = []
    pairs = pair.split(',')
    pairs.each do |pair|
      values = pair.split('-')
      ranges << Range.new(values[0].to_i, values[1].to_i)
    end
    ranges
  end
end

# a.include?(b.begin && b.end)
test = CleanUp.new('test_input.txt')
p test.range_creator('2-4,6-8000')