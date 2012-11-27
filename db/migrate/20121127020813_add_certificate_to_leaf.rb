class AddCertificateToLeaf < ActiveRecord::Migration
  def self.up
  	add_attachment :leafs, :certificate
  end

  def self.down
  	remove_attachment :leafs, :certificate
  end
end
