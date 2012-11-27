class ModifyCoordinatesOfLeafs < ActiveRecord::Migration
  def self.up
  	rename_column :leafs, :lat, :lat0
  	add_column :leafs, :lat1, :float
  	rename_column :leafs, :lon, :lon0
  	add_column :leafs, :lon1, :float
  	rename_column :leafs, :alt, :alt0
  	add_column :leafs, :alt1, :float
  end

  def self.down
  	rename_column :leafs, :lat0, :lat
  	remove_column :leafs, :lat1
  	rename_column :leafs, :lon0, :lon
  	remove_column :leafs, :lon1
  	rename_column :leafs, :alt0, :alt
  	remove_column :leafs, :alt1
  end
end
