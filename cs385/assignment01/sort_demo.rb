#!/usr/bin/ruby
# param a is an Array of numbers
class Array
  def to_s
    self.join ','
  end
end

def gen_insertion_sort
  return Proc.new { |a|
    # a[0], being a single number, is sorted
    comparison_count = 0

    n = a.size
    # Assume a[0]..a[j-1] is sorted in
    # nondescending order before a run of the loop.
    # The "index j" run of the loop will insert a[j]
    # in a[0]..a[j-1].
    1.upto(n-1) do |j|
      key = a[j]
      # Push elements that are bigger than "key" to the right
      # to make room for inserting "key"
      # Note that since a[0]..a[j-1] is sorted, we can just
      # stop when we see a element no larger than "key."
      k = j-1
      while (k >= 0 and a[k] > key and comparison_count += 1)
        a[k+1] = a[k]
        k = k-1
      end # while
      # Since k has been decremented, a[k+1] is the element
      # to be overwritten by the key
      a[k+1] = key
    end
    comparison_count
  }
end

def gen_selection_sort
  return Proc.new { |a|  # dunno about this Proc thing... I'm just trying to get a grip on ruby
    comparison_count = 0
    0.upto(a.size - 2) { |i|
      # find the least value element from index i onward
      least = i
      j = i+1
      j.upto(a.size - 1) { |j|
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

def test_sorting_algorithm(max_n, delta_n, sort_method, test_method)
  if test_method == "comparisons"
    n = delta_n
    while n <= max_n
      comparison_count = sort_method.call(gen_random_array(n))
      printf("%10d %10d\n", n, comparison_count)
      n += delta_n
    end
  elsif test_method == "time"
    n = delta_n
    while n <= max_n
      a = gen_random_array(n)
      time_start = Time.now
      sort_method.call(a)
      time_end = Time.now
      printf("%10d %10f\n", n, time_end.to_f - time_start.to_f)
      n += delta_n
    end
  end
end

def usage
  puts "usage: sort_test (insertion|selection) (comparisons|time)"  # TODO: add support for changing the max n and delta n
end

if ARGV.size != 2
  usage()
  return 0
end

if ARGV[0] == "insertion"
  if ARGV[1] == "time"
    test_sorting_algorithm(1000, 10, gen_insertion_sort, "time")
  elsif ARGV[1] == "comparisons"
    test_sorting_algorithm(100, 1, gen_insertion_sort, "comparisons")
  else
    usage()
  end
elsif ARGV[0] == "selection"
  if ARGV[1] == "time"
    test_sorting_algorithm(1000, 10, gen_selection_sort, "time")
  elsif ARGV[1] == "comparisons"
    test_sorting_algorithm(100, 1, gen_selection_sort, "comparisons")
  else
    usage()
  end
else
  usage()
end
