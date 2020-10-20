
module Enum
 
   def my_each
  
   c= yield  unless block_given?
  
    for c in self
    puts c
    end
   end
end

include Enum  
# self.my_each 
# my_each([1,2,3,4,5]) 
[1,2,3,4,5].my_each{|i|}