class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :user

	scope :newer_first, -> {order('created_at DESC')}
end
