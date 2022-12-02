# frozen_string_literal: true

f = File.read('test_input.txt')
input = f.gsub(/[XYZ]/, 'X' => 'A', 'Y' => 'B', 'Z' => 'C')

# Handle parsing of game of Rock, Paper, Scissors
# A for Rock, B for Paper, and C for Scissors
class RPS
  # Hash of each choice with an array of [beats, loses]
  RULES = {
    'A' => %w[C B],
    'B' => %w[A C],
    'C' => %w[B A]
  }
end
