# frozen_string_literal: true

# Read list of rucksack contents, find common values, score values
class Rucksacks
  attr_reader :input

  def initialize(input)
    @input = File.open(input).readlines
  end

  def part_one
    total_score = 0
    @input.each do |rucksack|
      value = common_value(split_compartments(rucksack))
      total_score += score(value[0])
    end
    puts "Part One: #{total_score}"
  end

  def part_two
    total_score = 0
    @input.each_slice(3) do |group|
      common = group[0].split('') & group[1].split('') & group[2].split('')
      total_score += score(common[0])
    end
    puts "Part Two: #{total_score}"
  end

  private

  # Receive string value of a rucksack. Splits into an array of 2 strings
  def split_compartments(rucksack)
    [rucksack[0, rucksack.length / 2], rucksack[rucksack.length / 2..]]
  end

  # Receive an array of 2 strings. Compares to find the common value in both strings.
  def common_value(compartments)
    compartments[0].split('') & compartments[1].split('')
  end

  # Convert common value to score
  def score(value)
    if ('A'..'Z').include?(value)
      value.ord - 38
    else
      value.ord - 96
    end
  end
end

test = Rucksacks.new('test_input.txt')
test.part_one
test.part_two

answer = Rucksacks.new('input.txt')
answer.part_one
answer.part_two
