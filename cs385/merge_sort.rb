#!/usr/bin/ruby
# merge two sorted arrays

# overriding the "convert to string" method of Array
class Array
  def to_s
    self.join ','
  end
end

def merge a,b
  aSize = a.size
  bSize = b.size
  # push sentinel value onto both arrays
  sentinel = [a[aSize-1], b[bSize-1]].max + 1
  a[aSize] = sentinel
  b[bSize] = sentinel

  puts "aSize = #{aSize}, bSize = #{bSize}"
  c = Array.new # for the answer
  i = 0  # index into array a
  j = 0  # index into array b
  k = 0.upto(aSize+bSize-1){|k| # k is index into c
    puts "a[i] = #{a[i]}, b[j] = #{b[j]}"
    if a[i] <= b[j]
      c.push a[i]
      i = i+1
    else
      c.push b[j]
      j = j+1
    end # if
  }
  return c
end # def merge

def merge_sort d
  if d.class != Array
    $stderr.print "Wrong argument type: " + $!
  end # if
  if d.size < 2
    return d
  else
    dSize = d.size
    half = dSize/2
    e = d[0..half-1]
    f = d[half..dSize]
    puts "e = #{e}, f = #{f}"
    return merge(merge_sort(e),merge_sort(f))
  end # if
end # def do_merge_sort

# main program takes an array as a command-line
# argument.  Enclose in double quotes if there
# might be spaces.

# Example: ./merge_sort.rb "[5, 2, -7, 3, 2]"
a = eval ARGV[0]
puts "Calling merge_sort for this array: #{a}"
a_sorted = merge_sort a
puts "Original array: #{a}"
puts "Sorted array: #{a_sorted}"

