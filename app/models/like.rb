class Like < ActiveRecord::Base
	belongs_to :messages
	  
	  def self.top_ten
	  	self.all.order('karma desc').first(10)
	  end

	  def self.untop_ten
	  	self.all.order('karma ASC').first(10)
	  end
end

