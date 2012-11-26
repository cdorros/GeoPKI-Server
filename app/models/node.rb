class Node < ActiveRecord::Base
  attr_accessible :l_child, :parent, :r_child, :sha, :level, :is_right_child

=begin
def Node.hello
	puts "hello"
end
=end


  def generate_tree
  	# destroy all nodes
  	Node.destroy_all

  	# pull in all the leaves and hash them
  	Leaf.all.each do |leaf|
  		@node = Node.new
  		@node.sha = leaf.sha
  		#@node.hash = H{leaf.certificate}
  		@node.level = 0
  		@node.save
  	end

  	# create parents and associate with children
  	@current_level = 1
  	@current_nodes = Node.find_all_by_level(@current_level - 1)
  	while @current_nodes.length > 1
	  	# determine how many parents are needed
	  	#if (Node.length % 2) == 0
	  	if(@current_nodes.length % 2) == 0
	  		@parent_count = @current_nodes.length / 2
	  	elsif @current_nodes.length == 1
	  		#only one at this level, must be root, so stop
	  		@parent_count = 0
	  	else
	  		@parent_count = (@current_nodes.length + 1) / 2
	  	end
	  	
	  	# add all current level nodes to "stack"
	  	@node_stack = Node.find_all_by_level(@current_level - 1)

	  	# create parents
		@parent_count.times do
	  		@parent = Node.new
	  		@parent.l_child = @node_stack.pop().id
	  		# try catch here since stack may be empty at this point
			begin
				@parent.r_child = @node_stack.pop().id
			rescue
			end
			@parent.level = @current_level
			# @parent.sha = hash children together to create new hash
			@parent.save
	  	end

	  	# associate parents and children together
		@parents = Node.find_all_by_level(@current_level)  	
		@children = Node.find_all_by_level(@current_level - 1)
		@parents.each do |parent|
			@child = Node.find_by_id(parent.l_child)
			@child.parent = parent.id
			@child.is_right_child = false
			@child.save

			begin
				@child = Node.find_by_id(parent.r_child)
				@child.parent = parent.id
				@child.is_right_child = true
				@child.save
			rescue
			end
		end

		# move to next level
		@current_level = @current_level + 1
		@current_nodes = Node.find_all_by_level(@current_level - 1)

	end
  	# END WHILE LOOP
  end
  	# note: root is only object in tree with no parents


end

