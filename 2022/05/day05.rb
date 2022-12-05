# frozen_string_literal: true

# Receive input of stacks of crates and instructions, create arrays for each crate stack
class Stacks
  attr_accessor :crate_stacks, :instructions

  def initialize(file)
    f = File.read(file).split("\n\n")
    @crate_stacks = crate_stack_gen(normalize_stacks(f[0]))
    @instructions = normalize_instructions(f[1].split("\n"))
  end

  def part_one
    move_crates
    top_items = String.new
    @crate_stacks.each do |stack|
      top_items << stack[0]
    end
    puts "Part One: #{top_items}"
  end

  private

  # Receive a string, generate normalized arrays for each line
  def normalize_stacks(string)
    stacks = []
    lines = string.split("\n")
    num_stacks = lines[-1].strip[-1]
    spaces = lines[0].length / num_stacks.to_i # each stack is 3 chars wide
    lines.each do |line|
      stacks << line.chars.each_slice(spaces + 1).map(&:join)
    end
    stacks[0..-2] # return only stack values
  end

  # Receive a normalized array and generate stacks
  def crate_stack_gen(lines)
    stacks = [[], [], [], [], [], [], [], [], []]
    lines.each do |line|
      line.each_with_index do |value, index|
        stacks[index] << value.strip.gsub(/[\[\]]/, '') unless value.strip == ''
      end
    end
    stacks
  end

  # Receive array of instruction strings, convert to array of number values [number to move, from crate, to crate]
  def normalize_instructions(lines)
    normalized_instructions = []
    lines.each do |line|
      normalized_instructions << line.gsub(/[a-z]/, '').split(' ')
    end
    normalized_instructions
  end

  def move_crates
    @instructions.each do |number, from, to|
      number = number.to_i
      from_stack = @crate_stacks[from.to_i - 1]
      to_stack = @crate_stacks[to.to_i - 1]
      until number.zero?
        crate = from_stack.shift
        to_stack.prepend(crate)
        number -= 1
      end
    end
  end
end

# test = Stacks.new('test_input.txt')
# test.part_one

answer = Stacks.new('input.txt')
answer.crate_stacks
answer.part_one
