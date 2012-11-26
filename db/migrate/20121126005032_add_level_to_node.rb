class AddLevelToNode < ActiveRecord::Migration
  def self.up
  	add_column :nodes, :level, :integer
  	add_column :nodes, :is_right_child, :boolean
  end

  def self.down
  	remove_column :nodes, :level, :integer
  	remove_column :nodes, :is_right_child, :boolean
  end
end
