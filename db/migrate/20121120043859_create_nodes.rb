class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :parent
      t.integer :l_child
      t.integer :r_child
      t.binary :sha

      t.timestamps
    end
  end
end
