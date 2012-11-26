class ChangeDataTypeForNodeRelations < ActiveRecord::Migration
  def self.up
    change_table :nodes do |t|
      t.change :parent, :binary
      t.change :l_child, :binary
      t.change :r_child, :binary
    end
  end

  def self.down
    change_table :nodes do |t|
      t.change :parent, :integer
      t.change :l_child, :integer
      t.change :r_child, :integer
    end
  end
end
