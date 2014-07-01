class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :user
	belongs_to :topic

	scope :newer_first, -> {order('created_at DESC')}
end
