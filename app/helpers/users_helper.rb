module UsersHelper
	def nickname_current_user
		'@' + current_user.nickname
	end 	
end
