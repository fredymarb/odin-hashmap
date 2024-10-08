require_relative "node"

class HashMap
  INITIAL_SIZE = 16
  LOAD_FACTOR = 0.75

  def initialize
    @capacity = INITIAL_SIZE
    @buckets = Array.new(@capacity)
    @size = 0
  end

  # converts the key into a hash
  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code % @buckets.length
  end

  # assigns key value pair to the HashMap
  def set(key, value)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    new_node = Node.new(key, value)
    if @buckets[index].nil?
      @size += 1
      return @buckets[index] = new_node
    end

    current = @buckets[index]
    prev = nil
    until current.nil?
      # if key already exist, update it's value
      return current.value = value if current.key == key

      prev = current
      current = current.next
    end

    prev.next = new_node
    @size += 1
    grow_table
  end

  # returns the value that is assigned to this key.
  # If key is not found, return nil
  def get(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    current = @buckets[index]
    until current.nil?
      return current.value if current.key == key

      current = current.next
    end

    nil
  end

  # returns true or false based on whether or not
  # the key is in the hash map.
  def has?(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    current = @buckets[index]
    until current.nil?
      return true if current.key == key

      current = current.next
    end

    false
  end

  # If the given key is in the hash map,
  # it should remove the entry with that key and
  # return the deleted entry’s value.
  # If the key isn’t in the hash map,
  # it should return nil.
  def remove(key)
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    current = @buckets[index]
    prev = nil

    until current.nil?
      if current.key == key
        if prev.nil?
          @buckets[index] = current.next
        else
          prev.next = current.next
        end
        @size -= 1
        return current.value
      end

      prev = current
      current = current.next
    end

    nil
  end

  # returns the number of stored keys in the hash map
  def length
    @size
  end

  # removes all entries in the hash
  def clear
    @buckets = Array.new(INITIAL_SIZE)
    @size = 0
  end

  # returns an array containing all the keys
  def keys
    keys_arr = []

    @buckets.each do |node|
      current = node

      until current.nil?
        keys_arr << current.key
        current = current.next
      end
    end

    keys_arr
  end

  # returns an array containing all the values
  def values
    values_arr = []

    @buckets.each do |node|
      until node.nil?
        values_arr << node.value
        node = node.next
      end
    end

    values_arr
  end

  # returns an array that contains each key, value pair.
  def entries
    entries_arr = []

    @buckets.each do |node|
      until node.nil?
        entries_arr << [node.key, node.value]
        node = node.next
      end
    end

    entries_arr
  end

  def grow_table
    bandwidth = LOAD_FACTOR * @capacity
    return unless @size >= bandwidth

    temp_arr = entries
    @capacity *= 2
    @size = 0
    @buckets = Array.new(@capacity)

    temp_arr.each do |key_value_pair|
      key = key_value_pair[0]
      value = key_value_pair[1]
      set(key, value)
    end
  end

  # outputs the hash map in a string format
  # for easy visualization
  def pretty_print
    @buckets.each_with_index do |node, index|
      print "Bucket #{index}: "

      while node
        print "(#{node.key}: #{node.value} ) -> "
        node = node.next
      end

      puts "nil"
    end
  end
end
