class MainController < ApplicationController
	def index
		if params["submit"] != nil
			@new_message = Message.new
			@new_message.name = params[:name]
			@new_message.text = params[:text]
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
	end	
end