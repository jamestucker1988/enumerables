# frozen_string_literal: true

module Enumerable
  # my_each
  def my_each
     return to_enum(__method__) unless block_given?
  
     i = 0
     while i < size
       is_a?(Range) ? yield(min + i) : yield(self[i])
       i += 1
     end
     self
  end

  #  [1, 2, 3].my_each { |elem| print "#{elem + 1} " }
 




  # my_each_with_index
  def my_each_with_index
    return to_enum(__method__) unless block_given?

    y = 0
    my_each do |x|
      yield x, y
      y += 1
    end
  end

  # print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" } 
  # my_select
  def my_select(arg = nil)
    arr = []
    unless block_given?
       if arg.is_a?(Proc)
         my_each do |elem| 
          if arg.call(elem)
            arr << elem 
          end
          end
       end
    end
    if block_given?
        my_each do |elem|
       if yield(elem)
        arr << elem
       end
      end
    end
    arr
  end
end
  # p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
  # p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
  # p [6, 11, 13].my_select(&:odd?) # => [11, 13]

  # my_map
  def my_map(proc = nil)
    arr = []
unless block_given?
    if proc.is_a?(Proc)
    my_each do |x| 
      arr << proc.call(x)
      end
    end
  end
    if block_given?
      my_each do |x| 
        arr << yield(x) 
      end
    end
    arr
  end

p [1, 2, 3].my_map { |n| 2 * n } # => [2,4,6]
p %w[Hey Jude].my_map { |word| word + '?' } # => ["Hey?", "Jude?"]
p [false, true].my_map(&:!) # => [true, false]
my_proc = proc { |num| num > 10 }
p [18, 22, 5, 6].my_map(my_proc) { |num| num < 10 } # => true true false false
puts
