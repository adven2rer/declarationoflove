class Message < ActiveRecord::Base
	  validates :name, presence: true, length: { maximum: 20 }
	  validates :text, presence: true, length: { maximum: 200}
	  has_one :like, dependent: :destroy
	  
	  PerPage = 10
	  def self.page(pg)
	  	pg = pg.to_i
	  	self.order('id desc').offset((pg-1)*PerPage).limit(PerPage)
	  end

	  def self.pgcount
	  	count % PerPage == 0 ? count / PerPage : count / PerPage + 1
 	  end

	  def self.last_messages
	  	self.order('id desc').first(10)
	  end
end
