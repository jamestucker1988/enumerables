module Enumerable
  def my_each(&p)
    return enum_for(__method__) unless block_given?
    for  i, k in self
      p.call(i, k)
    end
  end

  # { 'a' => 1, 'b' => 2 }.my_each { |x, y| puts x, y }
  # my_each_with_index
  def my_each_with_index
    return to_enum(__method__) unless block_given?

    y = 0
    my_each do |x|
      yield x, y
      y += 1
    end
  end

  # { 'a' => 1, 'b' => 2 }.my_each_with_index { |x, y| puts x, y }
  # select
  def my_select
    arr = []
    my_each { |x| arr << x unless yield(x) == false }
    puts arr
  end

  # [1, 4, 6, 8].my_select { |n| n > 2 }
  # my_map
  def my_map(proc=nil)
    arr = []
    if proc
    my_each { |e| arr << proc.call(e) }
      
    else
      my_each { |e| arr << e }
      
    end
     arr
  end

  # [8, 2, 3, 4, 5].my_map { |n| n - 2}
#   my_proc = proc { |num| num > 10 }
# p [18, 22, 5, 6].my_map(my_proc) { |num| num < 10 }
# p [false, true].my_map(&:!) # => [true, false] 
# p [1, 2, 3].my_map { |n| 2 * n } # => [2,4,6]
  # my_all
  def my_all
    return to_enum(__method__) unless block_given?

    my_each do |e|
      return puts false if yield(e) == false
    end
    puts true
  end

  # [1, 2, 3, 4, 5].my_all { |x| x < 7}
  # my_any?
  def my_any?(arg=nil) 
      if  block_given?
        my_each {|item| return true if yield(item)==true} 
      elsif arg.is_a?(Class) 
           my_each {|item| return true if item.is_a?(arg) }
      elsif arg.is_a?(Regexp)
        my_each {|item| return true if arg.match?(item.to_s)}
      elsif  arg.nil? == false 
        my_each {|item| return true if arg==item}
      else
        my_each {|item| return true if item }
      
      end
      false
  end

# p [7, 10, 3, 5].my_any?(&:even?) # => true
# p [7, 10, 4, 5].my_any?(&:even?) # => true
# p %w[q r s i].my_any? { |char| 'aeiou'.include?(char) } # => true
# p [7, 11, 3, 5].my_any?(&:even?) # => false
# p %w[q r s t].my_any? { |char| 'aeiou'.include?(char) } # => false
  
# #test cases required by tse reviewer
# p [3, 5, 4, 11].my_any? # => true
# p [1, nil, false].my_any?(1) # => true
# p [1, nil, false].my_any?(Integer) # => true
# p %w[dog door rod blade].my_any?(/z/) # => false
# p [1, 2, 3].my_any?(1) # => true




  
  
  # my_none
  def my_none?(arg=nil,&proc)
    !my_any?(arg,&proc)
  end
# p [1, 2, 3].my_none? # => false
# p [1, 2, 3].my_none?(String) # => true
# p [1, 2, 3, 4, 5].my_none?(2) # => false
# p [1, 2, 3].my_none?(4) # => true
# p [3, 5, 7, 11].my_none?(&:even?) # => true
# p %w[sushi pizza burrito].my_none? { |word| word[0] == 'a' } # => true
# p [3, 5, 4, 7, 11].my_none?(&:even?) # => false
# p %w[asparagus sushi pizza apple burrito].my_none? { |word| word[0] == 'a' } # => false
def my_count(*args)
  array = is_a?(Range) ? to_a : self
  return array.length if !block_given? && args.empty?

  number = 0
  if block_given?
    num_elements = []
    array.my_each do |item|
      if yield(item)
        num_elements << item
        number = num_elements.length
      end
    end
  else
    array.my_each { |i| number += 1 if i == args[0] } unless args.empty?
  end
  number
end
  p [1, 4, 3, 8].my_count(&:even?) # => 2
  # p %w[DANIEL JIA KRITI dave].my_count { |s| s == s.upcase } # => 3
  # p %w[daniel jia kriti dave].my_count { |s| s == s.upcase } # => 0
  # test cases required by tse reviewer
  p [1, 2, 3].my_count # => 3
  p [1, 1, 1, 2, 3].my_count(1) # => 3


end
