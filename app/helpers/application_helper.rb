module ApplicationHelper
	def inclinator(count, one, many)
		if (count == 1)
			return one 
		else 
			return many
		end		
	end 	
end
