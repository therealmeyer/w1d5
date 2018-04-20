
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

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    Raise "Error: not child!" if child_node.parent != self
    child_node.parent=(nil)
  end

  def dfs(target)
    return self if value == target
    self.children.each do |child|
      search_res = child.dfs(target)
      return search_res unless search_res.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      el = queue.shift
      return el if el.value == target
      el.children.each { |child| queue << child }
    end
  end


end
