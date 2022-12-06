# frozen_string_literal: true

# Receive a string of chars, find markers
class CommsDevice
  attr_accessor :input

  def initialize(file)
    @input = File.read(file)
  end

  def part_one
    i = 0
    n = i + 4
    until n == @input.length
      return n if @input[i...n].split(//).uniq.length == 4

      i += 1
      n += 1
    end
  end

  def part_two
    i = 0
    n = i + 14
    until n == @input.length
      return n if @input[i...n].split(//).uniq.length == 14

      i += 1
      n += 1
    end
  end
end

test = CommsDevice.new('test_input.txt')
test.part_one

answer = CommsDevice.new('input.txt')
answer.part_one
p answer.part_two
