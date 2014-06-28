load 'trie_funcs.rb'

class TrieNode
	attr_accessor :is_end
	attr_reader :value, :leaves
	
	def initialize(value)
		@leaves = Hash.new
		@value = value
		@is_end = false
	end
	
	def add_leaf(value)
		index = get_c_index(value)
		next_node = leaves[index]
		if next_node == nil
			next_node = TrieNode.new(value)
			leaves[index] = next_node
		end
		next_node
	end
end

class Trie
	attr_reader :root

	def initialize
		@root = TrieNode.new("root")
	end
end