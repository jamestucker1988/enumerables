module Enumerable
  def my_each(&p)
    return enum_for(__method__) unless block_given?

    each do |i, k|
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

  # [1,4,6,8].my_select { |n| n>2  }
  #  [8,2,3,4,5].my_map{|n|  n-2}
  # my_map
  def my_map
    arr = []
    my_each { |e| arr << yield(e) }
    puts arr
  end

  #  [8,2,3,4,5].my_map{|n|  n-2}
  # my_all
  def my_all
    return to_enum(__method__) unless block_given?

    my_each do |e|
      return puts false if yield(e) == false
    end
    puts true
  end

  # [1,2,3,4,5].my_all { |x| x<7}
  # my_any
  def my_any
    return to_enum(__method__) unless block_given?

    my_each do |e|
      return puts true if yield(e) == true
    end
    puts false
  end

  # [1,8,9,10,15].my_any { |x| x<7}
  # my_none
  def my_none
    my_each do |e|
      return puts false if yield(e) == (
          nil || false)
    end
    true
  end
  # [1,3,5].my_none {|x| x%2!=0 }

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
