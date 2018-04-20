
class PolyTreeNode

  attr_reader :parent, :children, :value
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(other_node)
    @parent = other_node
    other_node.children << self unless other_node.children.include?(self)
  end

  


end
