# str = "abc"

# puts enum = str.enum_for(:each_byte)
# enum.each { |b| puts b }
# class Greeter
#   def initialize(name)
#     @name = name
#   end

#   def xyz
#     "#{xyz.to_s.capitalize}, #{@name}!"
#   end
# end
# greeter = Greeter.new('Ben')
# greeter.xyz

# class Users
#   include Enumerable

#   def initialize
#     @users = %w[John Mehdi Henry]  
#   end
# end

# Users.new.map { |user| user.upcase }

# string = "A string".to_a
# puts string
# Array(string)
# def string.to_a
#    split('')
#    puts self
# end
str = "xyz"

module Enumerable
  # a generic method to repeat the values of any enumerable
  def repeat(n)
    raise ArgumentError, "#{n} is negative!" if n < 0
    return to_enum(:repeat,n) unless block_given?
       # __method__ is :repeat here
   
    each do |*val|
      n.times { yield *val }
    end
  end
end

 puts %i[hello world india].repeat(2)