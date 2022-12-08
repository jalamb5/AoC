# frozen_string_literal: true

# Receive a map of trees, find the ones that are visible
class TreeMap
  attr_accessor :input, :height, :width

  def initialize(file)
    @input = File.readlines(file, chomp: true)
    @height = @input.length
    @width = @input[0].length
  end

  def visible_trees
    trees = (@height * 2) + (@width * 2)
    trees += horizontal_trees
    # trees += vertical_trees
  end

  def horizontal_trees
    # left to right
    trees = 0
    @input.each_with_index do |line, index|
      next if index.zero? || index == @height

      arr = line.split('')
      arr.map(&:to_i).each_with_index do |num, idx|
        trees += 1 if ![0, @width].include?(idx) && (arr[0...idx - 1].all? { |val| num > val.to_i })
        p arr[0...idx - 1]
      end
    end
    trees
  end
end

test = TreeMap.new('test_input.txt')
test.horizontal_trees
