class MainController < ApplicationController
	has_mobile_fu(:true)
	def index
		if params["submit"] != nil and cookies[:posted] == nil
				@new_message = Message.new(params[:message].permit(:name, :text))
				@new_message.save

				new_like_object = Like.new
				new_like_object.karma = 0
				new_like_object.message_id = @new_message.id
				new_like_object.save

			if @new_message.save
				cookies[:posted] = { :value => "true", :expires => 1.minute.from_now }	
				@saved = true
			end
		else
			@saved == false
	    end

	    if params["like_btn"] != nil or params["dislike_btn"] != nil 
	    	p = params[:message_id]
		end	    

	   	if params["like_btn"] != nil and cookies[(p)] == nil
	   		message_find = Message.find(p)
	   		message_find.like.karma = message_find.like.karma + 1
	   		message_find.like.save
	   		cookies[(p)] = "liked"
	   		if message_find.like.karma > 0
	   			message_find.like.positive = true
	   			message_find.like.save
			end
	    end

	    if params["dislike_btn"] != nil and cookies[(p)] == nil  
	    	message_find = Message.find(p)
	   		message_find.like.karma = message_find.like.karma - 1
	   		message_find.like.save
	   		cookies[(p)] = "disliked"
	   		if message_find.like.karma <= -10
	   			message_find.destroy
	   		end
	   		if message_find.like.karma <= 0
	   			message_find.like.positive = false
	   			message_find.like.save
			end
	   	end

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

	def show 
		if params["like_comment"] != nil
	    	c = params[:comment_id]
	    end

   	    @message = Message.find(params[:id])

	   	if params["like_btn"] != nil and cookies[@message.id] == nil
	   		message_find = Message.find(@message.id)
	   		message_find.like.karma = message_find.like.karma + 1
	   		message_find.like.save
	   		cookies[@message.id] = "liked"
	   		if message_find.like.karma > 0
	   			message_find.like.positive = true
	   			message_find.like.save
			end
	    end

        if params["comment"]
			comment = Comment.new
			comment.text = params[:text]
			comment.message_id = params[:id]
			comment.likes = 0
			comment.save
    	end

	   	if params["like_comment"] != nil and cookies[(c)] == nil
	   		comment = Comment.find(c)
	   		comment.likes = comment.likes + 1
	   		comment.save
	   		cookies[(c)] = "comment_liked"
	    end

    	@comments = @message.comments

    	@message.comments.all.each do |comment|
	    	if cookies[comment.id] != nil
	    		@comment_liked = true
	    	end
	    end	
  	end
end