class Array

  def to_hash
    hash = Hash.new
    each { |x, y| hash[x] = y }
    hash
  end

  def index_by
    hash = {}
    each { |element| hash[yield element] = element }
    hash
  end

  def subarray_count(subarray)
    array_length = self.length
    subarray_length = subarray.length
    index = 0
    count = 0
    if subarray_length <= array_length
      index = 0
      while index < array_length
        shifted_array = self[index..(index + subarray_length - 1)]
        count += 1 if shifted_array == subarray
        index += 1
      end
    end
    count
  end

  def occurences_count
    hash = Hash.new(0)
    self.each { |x| hash[x] = hash[x] + 1 }
    hash
  end
end
