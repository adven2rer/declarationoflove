class Like < ActiveRecord::Base
	belongs_to :messages
	  
	def self.top_ten
		self.where(:positive => true).order('karma desc').first(10)
    end
end