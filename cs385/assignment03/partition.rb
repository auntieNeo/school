# performs list partitioning in linear time
# without nonconstant external storage, for use in
# C.A.R. Hoare's Quicksort or Quickselect, as well
# as Blum, et al.'s linear time selection algorithm.

class Array
  def to_s
    self.join ','
  end
  def partition(left, right, pivotindex)
    self[right],self[pivotindex]=self[pivotindex],self[right]
	puts "Array after swapping pivot to the right: #{self}"
	storeindex = left
	left.upto(right-1) do |i|
	   if self[i] < self[right] # put small numbers left
		  self[storeindex],self[i]=self[i],self[storeindex]
		  puts "store index = #{storeindex}"
		  puts "Array is #{self}"
		  storeindex = storeindex+1		  
	   end # if
	end # do
	self[right],self[storeindex]=self[storeindex],self[right]
    puts "final answer: #{self}"
    self
  end # partition
end # class Array