# frozen_string_literal: true

# Handle parsing of game of Rock, Paper, Scissors
# A for Rock, B for Paper, and C for Scissors
class RPS
  attr_reader :input

  # Hash of each choice with an array of [beats, loses]
  RULES = {
    'A' => %w[C B],
    'B' => %w[A C],
    'C' => %w[B A]
  }

  SCORE = {
    'A' => 1,
    'B' => 2,
    'C' => 3
  }

  def initialize(file)
    f = File.open(file).readlines
    # @input = f.each { |line| line.gsub!(/[XYZ]/, 'X' => 'A', 'Y' => 'B', 'Z' => 'C') }
    @input = f
  end

  def part_one
    total_score = 0
    @input.each do |round|
      elf = round.split[0]
      player = round.split[1]
      total_score += if elf == player
                       SCORE[player] + 3
                     elsif elf == RULES[player][0]
                       SCORE[player] + 6
                     else
                       SCORE[player]
                     end
    end
    total_score
  end

  def part_two
    total_score = 0
    @input.each do |round|
      elf = round.split[0]
      player = round.split[1]
      total_score += if player == 'X'
                       SCORE[RULES[elf][0]]
                     elsif player == 'Y'
                       SCORE[elf] + 3
                     else
                       SCORE[RULES[elf][1]] + 6
                     end
    end
    total_score
  end
end

game = RPS.new('input-2.txt')
p game.part_two
