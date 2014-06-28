load 'trie_model.rb'
load 'trie_funcs.rb'

trie = Trie.new

add_string_to_trie(trie, "super superman soup surprise ssuss")
matches = find_words(trie, "su")

matches.each {|m| puts m}