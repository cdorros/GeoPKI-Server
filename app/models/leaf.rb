require 'digest/sha1'
# http://stackoverflow.com/questions/3393143/before-create-in-rails-model

class Leaf < ActiveRecord::Base
  attr_accessible :alt, :lat, :lon, :name
  
  before_create :set_hash
  before_update :set_hash
  
  def set_hash
    self.sha = Digest::SHA1.hexdigest "#{self.lat}/#{self.lon}/#{self.alt}/#{self.name}"
  end
end
