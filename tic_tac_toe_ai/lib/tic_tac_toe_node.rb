require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode
  attr_reader :board, :next_mover_mark
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board 
    @next_mover_mark = next_mover_mark 
    @prev_move_pos = prev_move_pos 
  end

  def losing_node?(evaluator)
    return false if board.over? && (board.winner == evaluator || board.winner == nil)
    return true if board.over? && board.winner != evaluator
    self.children.each do |child|
      child.losing_node?(evaluator)
    end 
  end

  def winning_node?(evaluator)
    return true if board.over? && board.winner == next_mover_mark 
    return false if board.over? && (board.winner != next_mover_mark || board.winner == nil)
    self.children.each do |child|
      child.winning_node?(evaluator)
    end 
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    childs = [] 
    # debugger
    board.rows.each_index do |row_idx| 
      board.cols.each_index do |col_idx|
        if board.rows[row_idx][col_idx].nil? 
          duplicated_board = board.rows.map { |row| row.dup } 
          duplicated_board[row_idx][col_idx] = next_mover_mark
          next_mover_mark == :x ? next_mark = :o : next_mark = :x
          childs << TicTacToeNode.new(duplicated_board, next_mark, [row_idx,col_idx])
        end 
      end 
    end 
    childs 
  end
end
