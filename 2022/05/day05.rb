# frozen_string_literal: true

# Receive input of stacks of crates and instructions, create arrays for each crate stack
class Stacks
  attr_accessor :crate_stacks, :instructions

  def initialize(file)
    f = File.read(file).split("\n\n")
    @crate_stacks = crate_stack_gen(normalize_stacks(f[0]))
    @instructions = f[1].split("\n")
  end

  private

  # Receive a string, generate normalized arrays for each line
  def normalize_stacks(string)
    stacks = []
    lines = string.split("\n")
    num_stacks = lines[0].length / 3 # each stack is 3 chars wide
    lines.each do |line|
      stacks << line.chars.each_slice(num_stacks + 1).map(&:join)
    end
    stacks[0..-2] # return only stack values
  end

  # Receive a normalized array and generate stacks
  def crate_stack_gen(lines)
    stacks = [[], [], []]
    lines.each do |line|
      line.each_with_index do |value, index|
        stacks[index] << value.strip.gsub(/[\[\]]/, '') unless value.strip == ''
      end
    end
    stacks
  end
end

test = Stacks.new('test_input.txt')
p test.crate_stacks

# Array.new(Array.new(lines.length - 1))

# a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
# b = [[],[],[]]

# a.each do |line|
#   line.each_with_index do |value, index|
#     b[index] << value
#   end
# end

