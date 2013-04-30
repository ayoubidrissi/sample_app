module ApplicationHelper
	# Return a title per page basis.
	def title
		base_title = "Ruby on rails tutorial"
		if @title.nil?
			base_title
	    else 
	    	"#{base_title} | #{@title}"
		end
	end	

	def logo
		image_tag("logo.png",:alt => "simple app", :class => "round")	
	end		
end
