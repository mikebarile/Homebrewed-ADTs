require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      @count += 1
      resize! if @count >= num_buckets
      self[num] << num
    end
  end

  def remove(num)
    if include?(num)
      @count -= 1
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    two_bucks = num_buckets * 2
    new_store = Array.new(two_bucks) { Array.new }
    @store.flatten.each do |anything|
      new_store[anything.hash % two_bucks] << anything
    end
    @store = new_store
  end
end
