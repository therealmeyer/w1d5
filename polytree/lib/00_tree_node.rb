
class PolyTreeNode

  attr_reader :parent, :children, :value
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(other_node)
    if other_node == nil
      @parent = nil
    else
      parent.children.delete(self) if parent != nil
      @parent = other_node
      other_node.children << self unless other_node.children.include?(self)
    end 
  end




end

n1 = PolyTreeNode.new("root1")
n2 = PolyTreeNode.new("root2")
n3 = PolyTreeNode.new("root3")

# connect n3 to n1
n3.parent = n1
# connect n3 to n2
n3.parent = n2

# this should work
raise "Bad parent=!" unless n3.parent == n2
raise "Bad parent=!" unless n2.children == [n3]

# this probably doesn't
raise "Bad parent=!" unless n1.children == []
