require_relative "lib/hashmap"

my_hash = HashMap.new
my_hash.set("name", "Fred")
my_hash.set("region", "Accra")
my_hash.set("age", "34")
my_hash.set("apple", "red")
my_hash.set("banana", "yellow")
my_hash.set("carrot", "orange")
my_hash.set("dog", "brown")
my_hash.set("elephant", "gray")
my_hash.set("frog", "green")
my_hash.set("grape", "purple")
my_hash.set("hat", "black")
my_hash.set("ice cream", "white")
my_hash.set("jacket", "blue")
my_hash.set("kite", "pink")
my_hash.set("lion", "golden")

# puts my_hash.entries
# my_hash.remove("grape")
my_hash.pretty_print
puts my_hash.length
