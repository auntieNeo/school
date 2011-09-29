# Quicksort, using partition.rb
# Pick as pivot the median among first, middle, and last
# elements.  Partition array using pivot and recursively
# call quicksort
require './partition.rb'
class Array
   def quicksort(left, right)
      if left == right
		return self
      elsif right <= left+4
	     return self.bubblesort(left,right)
      end # if

	  # You can fill in the rest and test it.
	  # This is an assignment problem for assignment #3.
	   

   end # quicksort
end # class Array
