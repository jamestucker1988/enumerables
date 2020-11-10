module Enumerable
  def my_each(&p)
    return to_enum(__method__) unless block_given?

    for i, k in self
      p.call(i, k)
    end
  end

  # { 'a' => 1, 'b' => 2 }.my_each { |x, y| puts x, y }
  #  (1..3).my_each {|x| puts x}
  # %w(1,2,3,4,5).my_each {|x| puts x}
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
  def my_all?(_var = nil)
    return to_enum(__method__) unless block_given?

    my_each do |e|
      return puts false if yield(e) == false
    end
    puts true
  end

  # [1, 2, 3, 4, 5].my_all { |x| x < 7}
  # my_any?
  def my_any?(arg=nil)
    if block_given?
      my_each { |item| return true if yield(item) == true}
    elsif arg.is_a?(Class)
      my_each { |item| return true if item.is_a?(arg) }
    elsif arg.is_a?(Regexp)
      my_each { |item| return true if arg.match?(item.to_s)}
    elsif arg.nil? == false
      my_each { |item| return true if arg == item}
    else
      my_each { |item| return true if item }

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
  def my_none?(arg=nil, &proc)
    !my_any?(arg, &proc)
  end
  # p [1, 2, 3].my_none? # => false
  # p [1, 2, 3].my_none?(String) # => true
  # p [1, 2, 3, 4, 5].my_none?(2) # => false
  # p [1, 2, 3].my_none?(4) # => true
  # p [3, 5, 7, 11].my_none?(&:even?) # => true
  # p %w[sushi pizza burrito].my_none? { |word| word[0] == 'a' } # => true
  # p [3, 5, 4, 7, 11].my_none?(&:even?) # => false
  # p %w[asparagus sushi pizza apple burrito].my_none? { |word| word[0] == 'a' } # => false
  # def my_count(*args)
  #   array = is_a?(Range) ? to_a : self
  #   return array.length if !block_given? && args.empty?

  #   number = 0
  #   if block_given?
  #     num_elements = []
  #     array.my_each do |item|
  #       if yield(item)
  #         num_elements << item
  #         number = num_elements.length
  #       end
  #     end
  #   else
  #     array.my_each { |i| number += 1 if i == args[0] } unless args.empty?
  #   end
  #   number
  # end
  def my_count(args=nil, &p)
    count = 0
    if p.is_a?(Proc)
      my_each { |e| count += 1 if p.call(e)}
    end

    if block_given? == false
      count = 0
      my_each do |element|
        if args == element
          count += 1
        elsif args.nil?
          return length
        end
      end

      count
    end
    if block_given?
      count = 0
      my_each do |element|
        count += 1 if yield(element)
      end
    end
    count
  end

  # p [1, 4, 3, 8].my_count(&:even?) # => 2
  # p %w[daniel jia kriti dave].my_count { |s| s == s.upcase } # => 0
  # test cases required by tse reviewer
  # p [1, 2, 3].my_count # => 3
  # p [1, 1, 1, 2, 3].my_count(1) # => 3

  def my_inject(arg1=nil, arg2=nil)
    if block_given?
      if arg1.is_a?(Integer)
        my_each do |e|
          arg1 = yield(arg1, e)
        end
        return arg1
      elsif arg1.nil?
        acc = 0
        my_each do |e|
          acc = yield(acc, e)
        end
        return acc
      end
    end
    unless block_given?
      acc = 0
      if arg1 == '+'
        my_each do |e|
          acc += e
        end
        return acc
      end
    end
    unless block_given?
      acc = 1
      if arg2.to_sym == :*
        my_each do |e|
          acc *= e
        end
        return acc * arg1
      elsif arg1.nil?
        my_each do |e|
          acc *= e
        end
      end
      acc
    end
  end

  p [1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem } # => 20
  p [1, 2, 3, 4].my_inject { |accum, elem| accum + elem } # => 10
  p [5, 1, 2].my_inject('+') # => 8
  p (5..10).my_inject(2, :*) # should return 302400
  p(5..10).my_inject(4) { |prod, n| prod * n } # should return 604800
end

def multiply_els(arg)
  arg.my_inject(1) { |r, x| r * x}
end
p multiply_els((2..5))
