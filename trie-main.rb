class TrieNode
	attr_reader :is_end
	attr_writer :is_end
	
	def initialize(value)
		@leaves = Hash.new
		@value = value
		is_end = false
	end
	
	def value
		@value
	end
	
	def leaves
		@leaves
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

def get_c_index(char)
	char.ord - 'a'.ord
end

class Trie
	def initialize
		@root = TrieNode.new("root")
	end
	
	def root
		@root
	end
end

def add_string_to_trie(trie, string)
	words = string.split(" ")
	words.each do |word|
		curr_node = trie.root
		i = 1
		word.each_char do |c|
			if is_alpha(c)
				curr_node = curr_node.add_leaf(c)
				if i == word.length
					curr_node.is_end = true
				end
			end
			i += 1
		end
	end
end

def is_alpha(char)
	char.match(/^[[:alpha:]]$/) != nil
end

def print_trie(trie)
	print_trie_helper(trie.root)
end

def print_trie_helper(node)
	if node.leaves.any?
		print "#{node.value}: "
		if node.is_end
			print "! "
		end
		node.leaves.each {|k,v| print_trie_helper(v)}
	else
		print "#{node.value}; "
		if node.is_end
			print "! "
		end
	end
end

def find_words(trie, substring)
	cs = substring.split('')
	i_cs = 0
	ms = Array.new
	
	find(trie.root, cs, i_cs, ms, "")
	
	ms.each {|match| puts match}
end

def find(node, cs, i_cs, ms, str)
	c_value = cs[i_cs]
	unless c_value == nil
		c_index = get_c_index(c_value)
		next_node = node.leaves[c_index]
	
		unless next_node == nil
			str << c_value
			
			if node.is_end
				puts "pushing #{str}"
				ms.push(str)
			end
			
			find(next_node, cs, i_cs+1, ms, str)
		end
	else
		get_all_words(node, ms, str)
	end
end

def get_all_words(node, ms, prefix)
	node.leaves.each do |k,leaf|
		tmp_str = prefix.dup
		
		tmp_str << leaf.value
		
		if leaf.is_end
			ms.push(tmp_str)
		end
		
		get_all_words(leaf, ms, tmp_str)
	end
end

trie = Trie.new
add_string_to_trie(trie, "super superman soup surprise ssuss")
find_words(trie, "su")