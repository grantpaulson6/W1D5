require_relative '../Poly_Tree_Node/lib/00_tree_node'
require 'byebug'

class KnightPathFinder
  attr_reader :root_node

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
    new_moves = KnightPathFinder.valid_moves(pos).reject { |pot_pos| @considered_positions.include?(pot_pos)}
    @considered_positions += new_moves
    new_moves
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

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(end_node)
    path = [end_node.value]
    current_node = end_node
    until current_node.parent.nil?
      path.unshift(current_node.parent.value)
      current_node = current_node.parent
    end
    path
  end

end