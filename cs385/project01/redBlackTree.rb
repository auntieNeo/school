class RedBlackNode
  attr_accessor :lnode, :rnode, :parent, :value, :red, :tree
  def initalize
    @red = true
  end

  def insert(value)
    if value < @value then
      if @lnode == nil then
        @lnode = RedBlackNode.new
        @lnode.value = value
        @lnode.red = true
        @lnode.parent = self
        @lnode.tree = @tree
        @lnode.insert_fix_color()
      else
        @lnode.insert(value)
      end
    elsif value > @value then
      if @rnode == nil then
        @rnode = RedBlackNode.new
        @rnode.value = value
        @rnode.red = true
        @rnode.parent = self
        @rnode.tree = @tree
        @rnode.insert_fix_color()
      else
        @rnode.insert(value)
      end
    end
  end

  protected
  def insert_fix_color
#    assert(@red, "insert_fix_color should only be called on red nodes.")
    if @parent then
      if @parent.red then
#      assert(@parent.parent.red == false, "Grandparent should be black.")
        # Both this node and its parent are red, which presents a problem. 
#        assert(@parent.parent and not @parent.parent.red, "A red node must have a parent at all times, and that parent must be black.")
        # Case I: The parent is an lnode.
        if @parent.parent.lnode and @parent.parent.lnode == @parent then
          # Case I-A: The uncle of this node is red.
          if @parent.parent.rnode and @parent.parent.rnode.red then
            # Recolor the nodes while retaining the black path-length, and then call insert_fix_color on the grandparent to fix possible red conflicts.
            @parent.red = false
            @parent.parent.rnode.red = false
            @parent.parent.red = true
            @parent.parent.insert_fix_color()
          # Case I-B: The uncle of this node is black.
          else
            # Case I-B-1: This node is an rnode.
            if self == @parent.rnode then
              # Rotate the tree left to put this node where its parent is.
              @parent.left_rotate()
              # The old @parent should now be @lnode, and both self and @lnode should be red.
#            assert(@red and @lnode.red)
              # Now we can call insert_fix_color on @lnode and it will drop into case I-B-2.
              @lnode.insert_fix_color
            # Case I-B-2: This node is an lnode.
            else
              # Recolor some nodes and perform a right rotation.
              @parent.red = false
              @parent.parent.red = true
              @parent.parent.right_rotate()
            end
          end
        # Case II: The parent is an rnode.
        elsif @parent.parent.rnode == @parent then
          # Case II-A: The uncle of this node is red.
          if @parent.parent.lnode and @parent.parent.lnode.red then
            # Recolor the nodes while retaining the black path-length, and then call insert_fix_color on the grandparent to fix possible red conflicts.
            @parent.red = false
            @parent.parent.lnode.red = false
            @parent.parent.red = true
            @parent.parent.insert_fix_color
          # Case II-B: The uncle of this node is black.
          else
            # TODO: check if the following is correct
            # Case II-B-1: This node is an lnode.
            if self == @parent.lnode then
              # Rotate the tree right to put this node where its parent is.
              @parent.right_rotate()
              # The old @parent should now be @rnode, and both self and @rnode should be red.
#            assert(@red and @rnode.red)
              # Now we can call insert_fix_color on @rnode and it will drop into case II-B-2.
              @rnode.insert_fix_color
            # Case II-B-2: This node is an rnode
            else
              # Recolor some nodes and perform a left rotation.
              @parent.red = false
              @parent.parent.red = true
              @parent.parent.left_rotate()
            end
          end
        end
      end
    elsif @red then
      # make sure the root is black
      @red = false
    end
  end

  def left_rotate
    # switch this node with its rnode
    @rnode.parent = @parent
    @parent = @rnode

    # set the rnode of this node to the old lnode of the new grandparent, if it exists
    @rnode = @parent.lnode
    if @rnode then
      @rnode.parent = self
    end

    # set the lnode of the new grandparent to this node
    @parent.lnode = self

    # inform the greatgrandparent of the change, if a greatgrandparent exists
    if @parent.parent then
      if @parent.parent.lnode == self then
        @parent.parent.lnode = @parent
      else
#        assert (@parent.parent.rnode == self, "This node shouldn't have been an orphan.")
        @parent.parent.rnode = @parent
      end
    # change the root of the tree to the new grandparent
    else
      @tree.setRoot(@parent)
    end
  end

  def right_rotate
    # switch this node with its lnode
    @lnode.parent = @parent
    @parent = @lnode

    # set the lnode of this node to the old rnode of the new grandparent, if it exists
    @lnode = @parent.rnode
    if @lnode then
      @lnode.parent = self
    end

    # set the rnode of the new grandparent to this node
    @parent.rnode = self

    # inform the greatgrandparent of the change, if a greatgrandparent exists
    if @parent.parent then
      if @parent.parent.lnode == self then
        @parent.parent.lnode = @parent
      else
#        assert (@parent.parent.rnode == self, "This node shouldn't have been an orphan.")
        @parent.parent.rnode = @parent
      end
    # change the root of the tree to the new grandparent
    else
      @tree.setRoot(@parent)
    end
  end

  def transplant(node)
    
  end

  public
  def print(fh)
    fh.write(sprintf("n_%d [label=%d style=filled color=%s fontcolor=white];\n",@value, @value, @red ? "red" : "black"))
    if @lnode != nil then
      fh.write(sprintf("n_%d -> n_%d;\n", @value, @lnode.value))
      @lnode.print(fh)
    end
    if @rnode != nil then
      fh.write(sprintf("n_%d -> n_%d;\n", @value, @rnode.value))
      @rnode.print(fh)
    end
  end
end

class RedBlackTree
  attr_accessor
  def initialize
    @root = nil
  end

  def search
  end

  def minimum
  end

  def maximum
  end

  def insert(value)
    if @root == nil then
      @root = RedBlackNode.new
      @root.value = value
      @root.red = false
      @root.tree = self
    else
      @root.insert(value)
    end
  end

  def print(filename)
    File.open(filename, "w") do |fh|
      fh.puts("digraph g {")
      if @root != nil then
        @root.print(fh);
      end
      fh.puts("}")
    end
  end

  def setRoot(node)
    @root = node
  end
end
