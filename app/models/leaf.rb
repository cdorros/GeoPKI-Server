require 'digest/sha1'
# http://stackoverflow.com/questions/3393143/before-create-in-rails-model

class Leaf < ActiveRecord::Base
  attr_accessible :alt0, :alt1, :lat0, :lat1, :lon0, :lon1, :name, :certificate, :sha
  has_attached_file :certificate

  validates_presence_of :alt0, :alt1, :lat0, :lat1, :lon0, :lon1, :name
  validates_attachment_presence :certificate
  validates_attachment_size :certificate, :less_than => 1.megabytes
  #validates_attachment_content_type :certificate, :content_type => ['application/x-x509-ca-cert']
  #validates_format_of :certificate_file_name, :with => %r{\.(der)$}i

  # add verification here that lon0 < lon1, etc

  def find_by_coordinates(lat, lon, alt)
  	
  	# convert longitude all positive format
  	if lon < 0
  		lon = lon + 360
  	end

  	@matching_node = nil
  	# loop through all leaves to find matching node
  	Leaf.all.each do |leaf|

  		# ------------LATITUDE-----------------
  		# 	sort first
  		@lat_range = [leaf.lat0, leaf.lat1]
  		@lat_range = @lat_range.sort
  		
  		# 	check if between
  		if !(lat.between?(@lat_range[0],@lat_range[1]))
  			#puts "between"
  			next
  		end

  		# ------------LONGITUDE-----------------
  		@lon_range = [leaf.lon0, leaf.lon1]
  		  	# convert longitude all positive format
  		if @lon_range[0] < 0
  			@lon_range[0] = @lon_range[0] + 360
  		end
  		if @lon_range[1] < 0
  			@lon_range[1] = @lon_range[1] + 360
  		end

  		# then sort
  		@lon_range = @lon_range.sort
  		
  		# 	check if between
  		if !(lon.between?(@lon_range[0],@lon_range[1]))
  			next
  		end

  		# ------------ALTITUDE-----------------
  		# 	sort first
  		@alt_range = [leaf.alt0, leaf.alt1]
  		@alt_range = @alt_range.sort
  		# 	check if between
  		if !(alt.between?(@alt_range[0],@alt_range[1]))
  			next
  		end

  		# if we've gotten this far, we found a match!
  		@matching_node = leaf
  	end
  	return @matching_node

  end # END find_by_coordinates

end # END Leaf class
