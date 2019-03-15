require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    unless parent_node.nil? || parent_node.children.include?(self)
      parent_node.children << self
    end
    
  end
  
  def add_child(child_node)
    child_node.parent = self    
  end

  def remove_child(child_node)
    raise unless child_node.is_a?(PolyTreeNode) && children.include?(child_node)
    child_node.parent = nil 
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child| 
      child_find = child.dfs(target_value)
      return child_find unless child_find.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each {|child| queue << child}
    end
    nil
  end
end