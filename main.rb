module Enumerable

  def my_each
    return enum_for(__method__) unless block_given?

    index = 0
    while index != length
    yield (self[index])
    
      index+=1
      
    end
  end


#  [1, 2, 3, 4, 5].my_each {|x|  puts x}

#  def my_each_with_index 
#        return to_enum(__method__) unless block_given?
#         index=0
#       while index < length
#         yield(self[index],index)
#       index +=1
#       end
# end

#  [1,2,3,4,5].my_each_with_index {|x,y| puts x,y }

 #select
 def my_map
   self.my_each {|e| puts yield(e) }
 end


#  [8,2,3,4,5].my_map{|n|  n+2}

 def my_select 
     arr =[]
     index=0
     while index < length
     arr << if yield(self[index])== true
      index+=1
 end

[1,4,6,8].my_select do |n|  
   if n > 2
      return n
   end 
 end

end 



















































#   [1,2,3,4,5].my_select do |a| 
#    index=0
#    while index < a.lenght
#       puts a[index]
#       index+=1
#    end 
#   end
