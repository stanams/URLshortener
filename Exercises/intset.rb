class MaxIntSet

  def initialize(max)
    @max = max
    @store = set_store

  end

  def set_store
    Array.new(@max) { false }
  end

  def insert(n)
    @store[n] = true
  end


  def remove(n)
    @store[n] = false
  end

  def include?(n)
    @store[n] == true
  end

end



class IntSet

  def initialize(n)
    @length = n
    @store = set_store
  end

  def set_store
    Array.new(@length) { [] }
  end

  def bucket_num(num)
    num % @length
  end

  def insert(num)
    if include?(num)
      return false
    else
      @store[bucket_num(num)] << num
    end
  end


  def remove(num)
    return false unless include?(num)
    @store[bucket_num(num)].delete(num)
  end

  def include?(num)
    @store[bucket_num(num)].include?(num)
  end

end

class ResizingIntSet < IntSet

  def initialize(length)
    super(length)
    @count = 0
  end

  def insert(num)
    if include?(num)
      return false
    else
      @store[bucket_num(num)] << num
      @count += 1
    end
    check_length
  end

  def check_length
    double_buckets if @count == @length
  end

  def double_buckets
    @count = 0
    old_set = @store
    @store = Array.new(@length * 2) { [] }
    @length = @store.length
    old_set.each do |bucket|
      bucket.each do |number|
        insert(number)
      end
    end
    @store
  end


end






















  #whitespace
