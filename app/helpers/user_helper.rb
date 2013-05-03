module UserHelper
	def gravatar_img(user,options = {:size => 50})
		gravatar_image_tag(user.email,:class => 'gravatar',
									  :alt => user.name,
									  :gravatar => options
			)
	end
end
