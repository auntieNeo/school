# Linear-time select using partition.rb
require './partition.rb'



class Array
   def orderstat(left, right, k) # k is rank
	# chop array into pieces of 5 elements.
	# Find median of each piece, putting all of 
	# them in an array, medArray
	numSubarrays = right-left+1/5
	sizeLastSubarray = 5
	if (right-left+1%5 != 0)
	    numSubarrays = numSubarrays+1 
		sizeLastSubarray = right-left+1%5
     end	# if	
	0.upto(numSubarrays-1){|s|
	   if s < numSubarrays-1
	   	0.upto(2){|i|
	   	  smallest = i
		  (i+1).upto(4){|j|
		     smallest = j  if self[5*s+j+left] <
						 self[5*s+smallest+left]	
		  }
		  self[5*s+i+left],self[5*s+smallest+left] =
			 self[5*s+smallest+left],
		      self[5*s+i+left] if smallest != i
	    }
	   elsif sizeLastSubarray >= 3
		0.upto(2){|i|
	   	  smallest = i
		  (i+1).upto(sizeLastSubarray-1){|j|
		     smallest = j  if self[5*s+j+left] <
					  self[5*s+smallest+left]	
		  }
		  self[5*s+i+left],self[5*s+smallest+left] =
		    self[5*s+smallest+left],
			   self[5*s+i+left] if smallest != i
	    }
        end	# if
	}  # 0.upto(numSubarrays-1)

	# Now that each subarray is sorted to the 3rd element,
	# we can gather the medians to the left end
	# How many elements are there to gather?
	if right-left+1 < 3
	  numSubarrayMedians = numSubarrays-1
	else
	  numSubarrayMedians = numSubarrays
	end # if
	0.upto(numSubarrayMedians-1){|i|
       self[left+5*i+2],self[left+i]=self[left+i],self[left+5*i+2]
	} # 0.upto(numSubarrayMedians-1)
	

	# Find the median m of the MedArray, recursively
	# using orderstat.
	


	# Partition original array (self) with m, using
	# the method from partition.rb



   end # orderstat
end # class Array