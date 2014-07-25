class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	belongs_to :topic
	#after_create :create_like
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
	mount_uploader :image, ImageUploader

	scope :newer_first, -> {order('rank DESC')}
  scope :visible_to, -> (user) {user ? all : joins(:topic).where('topics.public' => true) }

	validates :title, length: {minimum: 5}, presence: true
	validates :body, length: {minimum: 20}, presence: true
	validates :topic, presence: true
	#validates :user, presence: true
	
	def points
		@likes = Likes.new(nil, self)
    @likes.post_likes_count * 7
	end

  	def update_rank
  		age = (self.created_at - Time.new(1970,1,1)) / 86400
  		new_rank = points + age

  		self.update_attribute(:rank, new_rank)
  	end
    

    def create_like(liker)
      @post = Likes.new(liker, self)
      @post.like!
    end
    def count_likes
      @likes = Likes.new(nil, self)
      @likes.post_likes_count
    end

    def unlike(liker)
      @post = Likes.new(liker, self)
      @post.unlike!
    end
    
  	private

    def update_post
    self.post.update_rank
    end
end
