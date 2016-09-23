require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
    @count = 0
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map.get(key)
      update_link!(link)
      link.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    @map.set(key, @store.insert(key, val))
    @count += 1

    eject! if @count > @max
    val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev

    stop = @store.last.next
    @store.last.next = link
    link.prev = @store.last
    link.next = stop
    stop.prev = link
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
    @count -= 1
  end
end
