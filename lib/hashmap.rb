require_relative "node"

class HashMap
  INITIAL_SIZE = 16
  LOAD_FACTOR = 0.75

  def initialize
    @buckets = Array.new(INITIAL_SIZE)
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
    return @buckets[index] = new_node if @buckets[index].nil?

    current = @buckets[index]
    until current.next.nil?
      # if key already exist, update it's value
      return current.value = value if current.key == key

      current = current.next
    end

    current.next = new_node
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
end

my_hash = HashMap.new
my_hash.set("name", "Fred")
my_hash.set("age", "21")
my_hash.set("region", "Accra")

p my_hash.get("name")
p my_hash.get("region")

p my_hash.has?("name")
p my_hash.has?("age")
p my_hash.has?("movie")
