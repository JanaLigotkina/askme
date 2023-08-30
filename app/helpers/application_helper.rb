module ApplicationHelper
	def inclinator(count, one, many)
		if (count == 1)
			return one 
		else 
			return many
		end		
	end 

	def current_user_header_color
		current_user&.header_color || "#370617"
	end 	
end
