class Comment < ActiveRecord::Base
	belongs_to :messages
	validates :text, presence: true, length: { maximum: 200}
end
