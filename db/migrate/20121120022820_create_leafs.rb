class CreateLeafs < ActiveRecord::Migration
  def change
    create_table :leafs do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.float :alt
      t.binary :sha

      t.timestamps
    end
  end
end
