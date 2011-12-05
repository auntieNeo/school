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
    return u.lselect(0, u.length - 1, k);
  end

  protected
  def lselect(left, right, k)
    if left == right then
      return self[left];
    end
    # partition the array recursively to find k
    pivot = partition(left, right);
    if pivot == k then
      return self[k];
    elsif k > pivot
      return lselect(pivot + 1, right, k);
    else
      return lselect(left, pivot - 1, k);
    end
  end

  private
  def partition(left, right)
    pivot = medianOfMedians();  # find the median of medians (recursively) to use as a pivot value
    i = left - 1;  # i indexes the lower partition
    j = left;  # j indexes the upper partition
    left.upto(right - 1) do |j|
      if(self[j] <= pivot) then
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

  def medianOfMedians
    # find all the medians
    medians = Array.new;
    i = 0;
    while i < self.length do
      medians << self.slice(i, 5).medianOfSmallArray;
      i += 5;
    end
    # return the median of the medians
    return medians.linearselect(medians.length / 2);
  end

  protected
  def medianOfSmallArray
#    assert(self.length <= 5, "medianOfSmallArray should only be called for arrays with less than 5 elements.");
#    assort(self.length > 0, "The array cannot be empty.");
    sorted = self.sort;  # sort the array in constant time, as the array cannot be larger than 5 elements
    return sorted[sorted.length / 2];
  end
end
