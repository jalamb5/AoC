# frozen_string_literal: true

# Receive a series of terminal outputs, generate directories
class TermParser
  attr_accessor :input, :dirs

  def initialize(file)
    @input = File.open(file).readlines
    @dirs = create_dirs
  end

  def part_one
    answer = 0
    construct_tree
    dir_size
    child_sizes
    full_sizes = {}
    @dirs.each do |directory|
      full_sizes[directory.current_dir] = directory.size + directory.children_sizes.uniq.sum
    end
    full_sizes.each do |_k, v|
      answer += v if v <= 100_000
    end
    p answer
  end

  private

  def create_dirs
    directories = []
    @input.each do |line|
      directories << Node.new(line.strip) if !line.include?('..') && line.include?('$ cd')
    end
    directories
  end

  def find_dir(line, cwd)
    dir = nil
    if line.include?('..')
      dir = cwd.parent
    else
      @dirs.each do |directory|
        dir = directory if directory.current_dir == line.gsub('$ cd ', '')
      end
    end
    dir
  end

  def read_contents(line, cwd)
    if line.include?('dir')
      cwd.children << find_dir(line.gsub('dir ', ''), cwd)
      find_dir(line.gsub('dir ', ''), cwd).parent = cwd
    else
      cwd.files << line
    end
  end

  def construct_tree
    cwd = nil
    @input.each do |line|
      if line.include?('$ cd')
        cwd = find_dir(line.strip, cwd)
      elsif line.include?('$ ls')
      else
        read_contents(line.strip, cwd)
      end
    end
  end

  def dir_size
    @dirs.each do |directory|
      directory.files.each do |file|
        directory.size += file.split(' ')[0].to_i
      end
    end
  end

  def child_sizes
    @dirs.each do |directory|
      parent_dir = directory.parent.nil? ? directory : directory.parent
      directory.children.each do |child|
        directory.children_sizes << child.size
        until parent_dir.nil?
          parent_dir.children_sizes << child.size
          parent_dir = parent_dir.parent
        end
      end
    end
  end
end

# Create a node for each directory that can be easily traversed
class Node
  attr_accessor :current_dir, :parent, :children, :files, :size, :children_sizes

  def initialize(line)
    @command = line
    @current_dir = cd_cleaner
    @parent = nil
    @children = []
    @files = []
    @size = 0
    @children_sizes = []
  end

  def cd_cleaner
    @command.gsub('$ cd ', '')
  end
end

test = TermParser.new('test_input.txt')
test.part_one

actual = TermParser.new('input.txt')
actual.part_one


# Other user's solution 
folder_sizes = Hash.new(0)

File.readlines('input.txt', chomp: true).map(&:split).each_with_object([]) do |line, stack|
  case line
  in ['$', 'cd', '..']
    stack.pop
  in ['$', 'cd', folder]
    stack.push folder
  in [size, file] if size.match?(/^\d+$/)
    stack.reduce('') { |j, i| folder_sizes[j += i] += size.to_i; j }
  else
  end
end

puts folder_sizes.values.reject { |i| i > 100_000 }.sum
puts folder_sizes.values.reject { |i| i < folder_sizes['/'] - 40_000_000 }.min
