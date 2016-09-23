require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    !get(key).nil?
  end

  def set(key, val)
    @count += 1 unless include?(key)
    resize! if count >= num_buckets
    @store[(key.hash % num_buckets)].insert(key, val)
  end

  def get(key)
    @store[(key.hash % num_buckets)].get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    @store[(key.hash % num_buckets)].remove(key)
  end

  def each(&prc)
    @store.each do |list|
      list.each do |el|
        prc.call(el.key, el.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    two_bucks = num_buckets * 2
    new_store = Array.new(two_bucks) { LinkedList.new }
    @store.each do |list|
      list.each do |el|
        new_store[el.key.hash % two_bucks].insert(el.key, el.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
