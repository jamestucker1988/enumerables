module Enumerable

  def my_each(&p)
    return enum_for(__method__) unless block_given?

    for i,k in self
    p.call(i,k)
     
    end
  end

[1,2,3,4,5].my_each

end
