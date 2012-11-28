require 'json'

class GeopkiController < ApplicationController
	def lookup
		
		# find the node that corresponds with the given coordinates
		
		# make sure all the params are set other return null
		if (params[:lat] && params[:lon] && params[:alt])
			@leaf_to_verify = Leaf.find_by_coordinates(params[:lat].to_f, params[:lon].to_f, params[:alt].to_f)
		
			@response = nil	
			# only get intermediate nodes if a match was found
			if(@leaf_to_verify)
				@node_to_verify = Node.find_by_sha(@leaf_to_verify.sha)

				# query for the values needed for verification + root
				begin
					@response = @node_to_verify.get_values_for_verification
				rescue
				end
			end
		end

		# respond with values
		respond_to do |format|
        	format.json { render json: @response }
        	#format.json { render json: @node_to_verify }
        end
	end
end