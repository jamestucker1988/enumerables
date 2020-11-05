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
      elsif arg.is_a?(Proc)
        my_each { |item| return true if item }
      elsif arg.nil? ==true
         return true
      end
     false
  end

  
  # test cases required by tse reviewer
  p [3, 5, 4, 11].my_any? # => true
  p [1, nil, false].my_any?(1) # => true
  p [1, nil, false].my_any?(Integer) # => true
  p %w[dog door rod blade].my_any?(/z/) # => false
  p [1, 2, 3].my_any?(1) # => true
  
  # my_none
  def my_none(arg=nil)
    my_each do |e|
      return puts false if yield(e) == (
          nil || false)
    end
    true
  end
  # [1, 3, 5].my_none { |x| x.odd? }

  def my_count
    arr = []
    my_each do |el|
      arr << yield(el)
      return size unless block_given?

      arr << yield(el) if yield(el) == false
      return arr.size

      ary = [1, 2, 4, 2]
      puts ary.my_count #=> 4
      ary.my_count(2) #=> 2
      ary.my_count { |x| x.even? } #=> 3
    end
  end
end
