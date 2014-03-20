class Comment < ActiveRecord::Base
	belongs_to :messages
end
