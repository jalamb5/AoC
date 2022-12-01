# frozen_string_literal: true

input = File.open('input.txt').readlines

def add_calories(input)
  value = 0
  values = []
  input.each do |line|
    line.chomp!
    if line != ''
      value += line.to_i
    else
      values << value
      value = 0
    end
  end
  values
end

add_calories(input).max
# Part One Answer: 71934

top_three = add_calories(input).max(3)
p top_three.sum

# Part Two Answer: 211447