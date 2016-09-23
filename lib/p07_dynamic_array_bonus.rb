class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i < -1 * count
    i %= count if i < 0

    @store[i]
  end

  def []=(i, val)
    return nil if i < -1 * count
    i %= count if i < 0
    until i < @store.length
      resize!
    end
    @count = i + 1 if i >= @count
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.any?{|el| el = val}
  end

  def push(val)
    self[@count] = val
  end

  def unshift(val)
    i = @count + 1
    until i == 0
      self[i] = self[i-1]
      i -= 1
    end
    self[0] = val
  end

  def pop
    return nil if @count == 0
    popped = @store[@count-1]
    @store[@count-1] = nil
    @count -= 1
    popped
  end

  def shift
    return nil if @count == 0
    first_el = first
    i = 0
    until i == @count-1
      self[i] = self[i+1]
      i += 1
    end
    @store[@count-1] = nil
    @count -= 1
    first_el
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each(&prc)
    i = 0
    until i == @count
      prc.call(@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    each_with_index { |el, i| return false if el != other[i] }
    @count == other.count
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(@store.length*2)
    i = 0
    until i == @store.length
      new_store[i] = @store[i]
      i += 1
    end
    @store = new_store
  end
end
