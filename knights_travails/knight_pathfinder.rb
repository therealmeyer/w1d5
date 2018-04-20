require_relative 'polytree_node'
require 'byebug'


class KnightPathFinder
  attr_reader :start_pos, :visited_positions
  MOVES = [[2,1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2],[-2,1],[-2,-1]]

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    # build_move_tree
  end

  def self.valid_moves(pos)
    positions = []
    MOVES.each do |move|
      pair = [pos.first+move[0], pos.last+move[1]]
      positions << pair if self.within_range?(pair)
    end
    positions
  end

  def self.within_range?(pos)
    (0...8).include?(pos.first) && (0...8).include?(pos.last)
  end

  def new_move_positions(pos)
    possible_moves = self.class.valid_moves(pos)
    new_positions = possible_moves.reject { |move| @visited_positions.include?(move)}
    @visited_positions = @visited_positions.concat(new_positions)
    new_positions
  end

  def build_move_tree
    root = PolyTreeNode.new(start_pos)
    @move_tree = root
    queue = [root]
    until queue.empty?
      el = queue.shift
      new_move_positions(el.value).each do |pos|
        el.add_child(PolyTreeNode.new(pos))
      end
      el.children.each do |child|
        new_move_positions(child.value).each do |new_pos|
          queue << child.add_child(PolyTreeNode.new(new_pos))
        end
      end
    end
    queue
  end

  def find_path(end_pos)
    node = @move_tree.dfs(end_pos)
    trace_path_back(node)
  end

private

  def trace_path_back(node)
    trace_back_path = []
    until node == nil
      trace_back_path << node.value
      node = node.parent
    end
    trace_back_path
  end
end
