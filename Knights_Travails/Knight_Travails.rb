require_relative '../Poly_Tree_Node/lib/00_tree_node'
require 'byebug'

class KnightPathFinder
  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
    build_move_tree
  end

  def build_move_tree
    queue = [@root_node]
    
    until queue.empty?
      current_node = queue.shift 
      
      new_move_positions(current_node.value).each do |pos|
        current_node.add_child(PolyTreeNode.new(pos))
      end
      current_node.children.each {|child| queue << child}
    end
  end

  def new_move_positions(pos)
    Knight.valid_moves(pos).reject { |pot_pos| @considered_positions.include?(pot_pos)}
  end

  def self.valid_moves(pos)
    delta_pos = [[1,-2],[-1,-2],[2,-1],[-2,-1],[2,1],[-2,1],[1,2],[-1,2]]
    possible_moves = []

    delta_pos.each do |delta|
      move = [pos[0]+delta[0],delta[1]+pos[1]]
      if move[0] >= 0 && move[0] <= 7 && move[1] >= 0 && move[1] <=7 
        possible_moves << move
      end   
    end
    possible_moves
  end

end