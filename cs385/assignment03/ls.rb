class Array
  public
  def linearselect(k)
#    u = self.uniq;  # search from the list of unique elements
    return self[self.lselect(0, self.length - 1, k)];
  end

  public
  def lselect(left, right, k)
    if left == right then
      return left;
    end
    # partition the array recursively to find k
    pivot = partition(left, right);
    if pivot == k then
      return k;
    elsif k > pivot then
      return lselect(pivot + 1, right, k);
    else
      return lselect(left, pivot - 1, k);
    end
  end

  private
  def partition(left, right)
#    printf("entered partition routine. left: %d  right: %d\n", left, right);
#    p self.slice(left..right);
    pivot = medianOfMedians(left, right);  # find the median of medians (recursively) to use as a pivot value
#    printf("optimal pivot index: %d\n", pivot);

    # put the pivot at the right end
    foo = self[right];
    self[right] = self[pivot];
    self[pivot] = foo;

    i = left - 1;  # i indexes the lower partition
    j = left;  # j indexes the upper partition
    left.upto(right - 1) do |j|
      if(self[j] <= self[right]) then
        # swap the element at index j into the lower partition, and increment both i and j
        foo = self[i + 1];
        self[i + 1] = self[j];
        self[j] = foo;
        i = i + 1;
        j = j + 1;
      else
        # leave the element at index j in the upper partition, and increment j
        j = j + 1;
      end
    end
    # swap the pivot element so that it lies between the two partitions
    foo = self[i + 1];
    self[i + 1] = self[right];
    self[right] = foo;

    # return the pivot index between the partitions
    return i + 1;
  end

  protected
  def medianOfMedians(left, right)
#    puts "entered medianOfMedians routine"
    # base case, simply find the median
    if right - left <= 5 then
      sorted = self.slice(left..right).sort;  # sort the array in constant time, as the array cannot be larger than 5 elements
      median = sorted[sorted.length / 2];
      i = left;
      while i <= right do
        if self[i] == median then
          return i;
        end
        i += 1;
      end
    end

    # find all the medians
    medians = Array.new;
    i = left;
    while i <= right do
      # sort half of the small sub array of 5 elements in constant time
      # sorting is performed in-place so that we can easily calculate and return the index of the median of medians
      j = i;
      while j < [i + 3, right].min do
        k = j + 1;
        least = j;
        while k < [i + 5, right + 1].min do
          if self[k] < self[least] then
            least = k;
          end
          k += 1;
        end
        foo = self[j];
        self[j] = self[least];
        self[least] = foo;
        j += 1;
      end
      # add one of the medians
      medians << MedianDatum.new(self[[i + 2, right].min], [i + 2, right].min);  # NOTE: for arrays smaller than 5, the best median isn't always chosen here, but that does not matter
      i += 5;
    end
#    printf "partly-sorted self:";
#    p self;
#    printf("medians: ");
#    p medians;
    # find the median of the medians recursively
    medianRank = medians.lselect(0, medians.length - 1, medians.length / 2);
    medianIndex = medians[medianRank].index;
#    printf("median of medians: %d\n", medians[medianRank].value);
#    printf("median index: %d\n", medianIndex);
    # calculate the index to return
    result = medianIndex;
    return result;
  end
end

class MedianDatum
  # this class is simply used as a tupple that can store both a value and an index, and is treated as though it were a number of its value
  attr_accessor :value, :index
  public
  def initialize(value, index)
    @value = value;
    @index = index;
  end

  def <(y)
    return @value < y.value;
  end

  def >(y)
    return @value > y.value;
  end

  def <=(y)
    return @value <= y.value;
  end

  def >=(y)
    return @value >= y.value;
  end

  def <=>(y)
    return @value <=> y.value;
  end
end
