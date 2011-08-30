#!/usr/bin/ruby
# param a is an Array of numbers
class Array
  def to_s
    self.join ','
  end
end

def insertion_sort a
  # a[0], being a single number, is sorted

  n = a.size
  # Assume a[0]..a[j-1] is sorted in
  # nondescending order before a run of the loop.
  # The "index j" run of the loop will insert a[j]
  # in a[0]..a[j-1].
  1.upto(n-1) do |j|
    puts "looping with j = #{j}"
    key = a[j]
    # Push elements that are bigger than "key" to the right
    # to make room for inserting "key"
    # Note that since a[0]..a[j-1] is sorted, we can just
    # stop when we see a element no larger than "key."
    k = j-1
    puts "k = #{k}"
    while k >= 0 and a[k] > key
      a[k+1] = a[k]
      k = k-1
    end # while
    # Since k has been decremented, a[k+1] is the element
    # to be overwritten by the key
    a[k+1] = key
    puts "a = #{a}"
  end # do
  return a
end # def insertion_sort

def gen_selection_sort
  return Proc.new { |a|  # dunno about this Proc thing... I'm just trying to get a grip on ruby
    comparison_count = 0
    0.upto(a.size - 2) { |i|
#      puts  "i = #{i}"
      # find the least value element from index i onward
      least = i
      j = i+1
      j.upto(a.size - 1) { |j|
#        puts "j = #{j}"
        comparison_count += 1
        if a[j] < a[least] then
          least = j
        end
      }
      # swap the element at index i with the element at index least
      temp = a[i]
      a[i] = a[least]
      a[least] = temp
    }
    comparison_count
  }
end

def gen_random_array n
  a = Array.new(n)
  0.upto(n - 1) { |i|
    a[i] = rand(2**(31) - 1)
  }
  return  a
end

def test_sorting_algorithm(max_n, delta_n, sort_method)
  n = 1
  while n <= max_n
    comparison_count = sort_method.call(gen_random_array(n))
    puts comparison_count
    n += delta_n
  end
end

#insertion_sort a
#selection_sort a
test_sorting_algorithm(100, 5, gen_selection_sort)
