# frozen_string_literal: true

module Enumerable
  # my_each
  def my_each(&p)
    return to_enum(__method__) unless block_given?

    each do |i, k|
      p.call(i, k)
    end
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum(__method__) unless block_given?

    y = 0
    my_each do |x|
      yield x, y
      y += 1
    end
  end

  # my_select
  def my_select
    arr = []
    my_each { |x| arr << x unless yield(x) == false }
    puts arr
  end

  # my_map
  def my_map(proc = nil)
    arr = []
    if proc
      my_each { |e| arr << proc.call(e) }

    else
      my_each { |e| arr << e }

    end
    arr
  end

  # my_all
  def my_all?(_var = nil)
    return to_enum(__method__) unless block_given?

    my_each do |e|
      return puts false if yield(e) == false
    end
    puts true
  end

  # my_any?
  def my_any?(arg=nil)
    if block_given?
      my_each { |item| return true if yield(item) == true }
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

  # my_none
  def my_none?(arg=nil, &proc)
    !my_any?(arg, &proc)
  end

  def my_count?(args=nil, &p)
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

  # my_inject
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
end

# multiply_els
def multiply_els(arg)
  arg.my_inject(1) { |r, x| r * x}
end
p multiply_els((2..5))
