# frozen_string_literal: true

# Take an input of elf assignment pairs and find the overlaps
class CleanUp
  attr_reader :input

  def initialize(file)
    @input = File.open(file).readlines
  end

  def part_one
    full_overlaps = 0
    @input.each do |line|
      ranges = range_creator(line)
      full_overlaps += 1 if fully_overlaps?(ranges[0], ranges[1])
    end
    puts "Part One: #{full_overlaps}"
  end

  def part_two
    any_overlaps = 0
    @input.each do |line|
      ranges = range_creator(line)
      any_overlaps += 1 if partially_overlaps?(ranges[0], ranges[1])
    end
    puts "Part Two: #{any_overlaps}"
  end

  private

  # Receive a string of ranges, convert to Ruby range objects
  def range_creator(pair)
    ranges = []
    pairs = pair.split(',')
    pairs.each do |assignment|
      values = assignment.split('-')
      ranges << Range.new(values[0].to_i, values[1].to_i)
    end
    ranges
  end

  # Receive 2 Ruby ranges, determine if either is fully included in the other
  def fully_overlaps?(range_one, range_two)
    range_one.include?(range_two.begin) && range_one.include?(range_two.end) ||
      range_two.include?(range_one.begin) && range_two.include?(range_one.end)
  end

  # Receive 2 Ruby ranges, determine if any overlap occurs
  def partially_overlaps?(range_one, range_two)
    range_one.include?(range_two.begin) || range_one.include?(range_two.end) ||
      range_two.include?(range_one.begin) || range_two.include?(range_one.end)
  end
end

answer = CleanUp.new('input.txt')
answer.part_one
answer.part_two
