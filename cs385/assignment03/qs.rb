class Array
  def quicksort
    qs(0, self.length - 1);
  end

  private
  def qs(left, right)
    if left < right then
      # partition step
      pivot = partition(left, right);

      # recursive step
      qs(left, pivot - 1);
      qs(pivot + 1, right);
    end
  end

  public
  def quickselect(k)
    u = self.uniq;  # search from the list of unique elements
    return u.qselect(0, u.length - 1, k)
  end

  protected
  def qselect(left, right, k)
    if left == right then
      return self[left];
    end
    # partition the array recursively to find k
    pivot = partition(left, right);
    if pivot == k then
      return self[k];
    elsif k > pivot
      return qselect(pivot + 1, right, k);
    else
      return qselect(left, pivot - 1, k);
    end
  end

  private
  def partition(left, right)
    pivot = self[right];  # pick an arbitrary pivot value # TODO: should be more random than this
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
end
