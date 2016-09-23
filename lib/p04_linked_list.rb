class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @start = Link.new
    @stop = Link.new
    @start.next = @stop
    @stop.prev = @start
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    next_el = @start.next
  end

  def last
    last_el = @stop.prev
  end

  def empty?
    first == @stop
  end

  def get(key)
    find(key).val
  end

  def include?(key)
    find(key) != @stop
  end

  def insert(key, val)
    found_link = find(key)
    unless found_link == @stop
      found_link.val = val
    else
      node = Link.new(key, val)
      last.next = node
      node.prev = last
      node.next = @stop
      @stop.prev = node
    end
  end

  def remove(key)
    if include?(key)
      current = find(key)
      current.next.prev = current.prev
      current.prev.next = current.next
    end
  end

  def each(&prc)
    current = first
    until current == @stop
      prc.call(current)
      current = current.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def find(key)
    current = first
    until current.key == key || current == @stop
      current = current.next
    end
    current
  end
end
