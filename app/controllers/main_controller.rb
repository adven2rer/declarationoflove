class MainController < ApplicationController
	has_mobile_fu 
    before_filter :force_mobile_format
	def index
		if params["submit"] != nil
			@new_message = Message.new(params[:message].permit(:name, :text))
			@new_message.save

			new_like_object = Like.new
			new_like_object.karma = 0
			new_like_object.message_id = @new_message.id
			new_like_object.save
	    end

	    if params["like_btn"] != nil or params["dislike_btn"] != nil 
	    	p = params[:message_id]
		end	    

	   	if params["like_btn"] != nil and cookies[(p)] == nil
	   		message_find = Message.find(p)
	   		message_find.like.karma = message_find.like.karma + 1
	   		message_find.like.save
	   		cookies[(p)] = "liked"
	    end

	    if params["dislike_btn"] != nil and cookies[(p)] == nil  
	    	message_find = Message.find(p)
	   		message_find.like.karma = message_find.like.karma - 1
	   		message_find.like.save
	   		cookies[(p)] = "disliked"
	   		if message_find.like.karma <= -10
	   			message_find.destroy
	   		end
	   	end

	    #if params[:page_find] != nil
	    #	page_find_params = params[:page_find].to_i
	    #	redirect_to ('Find page', '/#{page_find_params}')
	    #end

	   	#message = Message.all
  	    #message.each do |m|
  	    #if Time.now.hour > m.created_at.hour + 5.hour 
  	    #	m.destroy
  	    #end
  		#end
  		if params[:page] != nil
  			@messages = Message.page(params[:page])
  		end

		if params[:page] == nil
			@messages = Message.last_messages
		end
		
		if Visits.all.empty?
			v = Visits.new
			v.all_not_unique_visits = 0
			v.all_unique_visits = 0
			v.save
		end 

		v = Visits.all[0]
		
		v.all_not_unique_visits = v.all_not_unique_visits + 1
		v.save

		@visits_not_unique = Visits.all[0].all_not_unique_visits

		if cookies[:visited] == nil
			cookies[:visited] = "true"
			v.all_unique_visits = v.all_unique_visits + 1
			v.save
		end	

		@visits_unique = Visits.all[0].all_unique_visits
	end	

	def about
	end
end