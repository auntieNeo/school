class Array
  public
  def quicksort
    qsort(0, self.length - 1);
  end

  private
  def qsort(left, right)
    if left < right then
      # partition step
      pivot = partition(left, right);

      # recursive step
      qsort(left, pivot - 1);
      qsort(pivot + 1, right);
    end
  end

  public
  def linearselect(k)
    u = self.uniq;  # search from the list of unique elements
    return u[u.lselect(0, u.length - 1, k)];
  end

  protected
  def lselect(left, right, k)
    if left == right then
      return self[left];
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
    printf("entered partition routine. left: %d  right: %d\n", left, right);
    p self.slice(left..right);
    pivot = self.slice(left..right).medianOfMedians() + left;  # find the median of medians (recursively) to use as a pivot value
    printf("optimal pivot index: %d\n", pivot);

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
  def medianOfMedians
    puts "entered medianOfMedians routine"
    # base case, simply find the median
    if self.length <= 5 then
      sorted = self.sort;  # sort the array in constant time, as the array cannot be larger than 5 elements
      return self.index(sorted[sorted.length / 2]);
    end

    # find all the medians
    medians = Array.new;
    i = 0;
    while i < self.length do
      # sort half of the small sub array in constant time
      # sorting is performed in-place so that we can easily calculate and return the index of the median of medians
      j = i;
      while j < [i + 3, self.length - 1].min do
        k = j + 1;
        least = j;
        while k < [i + 5, self.length].min do
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
      medians << self[[i + 2, self.length - 1].min];  # NOTE: for arrays smaller than 5, the best median isn't always chosen here, but that does not matter
      i += 5;
    end
    puts "partly-sorted self:"
    p self;
    # find the median of the medians recursively
    medianIndex = medians.lselect(0, medians.length - 1, medians.length / 2);
    # calculate the index to return
    result = [(medianIndex * 5) + 2, self.length - 1].min;
    return result;
  end
end
