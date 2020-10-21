module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    index = 0
    while index != length
      yield to_a[index]
      index += 1
    end
  end
end

[1, 2, 3, 4, 5].my_each { |i| puts i }
