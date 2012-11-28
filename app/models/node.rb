require 'digest'

class Node < ActiveRecord::Base
  attr_accessible :l_child, :parent, :r_child, :sha, :level, :is_right_child

  def self.get_root_node
  	return Node.find_by_parent(nil)
  end

  # gets intermediate nodes and root needed for hash verification
  # and formats in an array. [node_to_verify.sibling, node_to_verify.sibling_isRight?, ...etc..., root]
  def get_values_for_verification
  	@intermediate_nodes = self.get_intermediate_nodes
    @array = []

    @intermediate_nodes.each do |node|
      @array << node.sha.to_s
      if node.is_right_child
        @array << "rchild"
      else
        @array << "lchild"
      end
    end

  	@array << Node.get_root_node.sha.to_s
    @array << "root"

  	return @array
    #return @intermediate_nodes
  end

  def get_intermediate_nodes
  	@current_node = self
  	@intermediate_nodes = []

  	# loop until we reach the root
  	while @current_node.parent != nil
  		@sibling = @current_node.get_sibling

  		# check if it actually has a sibling
  		if @sibling
  			@intermediate_nodes << @sibling
  		end

  		# if it didn't have siblings, then it must be an only child
  		# ..since it's not the root
  		# so, continue...

  		@current_node = Node.find_by_id(@current_node.parent)
  	end

  	return @intermediate_nodes
  end

  def get_sibling
  	@sibling = nil

  	# break if we are at root (orphan)
  	if self.parent == nil
  	elsif !(self.is_right_child)
  		# get the right child if this node is a left child
  		begin
  			@sibling = Node.find_by_id(Node.find_by_id(self.parent).r_child)
  		rescue
  		end
  	else
  		# get the left child if this node is a right child
  		@sibling = Node.find_by_id(Node.find_by_id(self.parent).l_child)
  	end
  	
  	return @sibling
  end # END get_sibling

  def self.generate_tree
  	# destroy all nodes
  	Node.destroy_all

  	# pull in all the leaves and hash them
  	Leaf.all.each do |leaf|
  		@node = Node.new
  		#@node.sha = Digest::SHA1.file(leaf.certificate.path).hexdigest
      @node.sha = leaf.sha
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
			# update left child
			@lchild = Node.find_by_id(parent.l_child)
			@lchild.parent = parent.id
			@lchild.is_right_child = false
			@lchild.save

			@rchild = nil
			# update right child
			begin
				@rchild = Node.find_by_id(parent.r_child)
				@rchild.parent = parent.id
				@rchild.is_right_child = true
				@rchild.save
			rescue
			end

			# check if the child is an only child
			if @rchild == nil
				# just copy the child's hash up
				parent.sha = @lchild.sha
			else
				# hash the concatenation of the children, H(lchild.sha+rchild.sha)
				parent.sha = Digest::SHA1.hexdigest @lchild.sha + @rchild.sha
			end

			parent.save
		end

		# move to next level
		@current_level = @current_level + 1
		@current_nodes = Node.find_all_by_level(@current_level - 1)

	end
  	# END WHILE LOOP
  end # END generate_tree
  	


end # END node class

