require 'rails_helper'
 
 describe FavoritesController do
 
   include TestFactories
   include Devise::TestHelpers
 
   before do 
     @topic = Topic.create
     @post = post_without_user({topic: @topic})
     if !@post.valid?
      raise @post.errors.full_messages.inspect
    end
     @user = authenticated_user
     sign_in @user
   end
 
   describe '#create' do
     it "creates a favorite for the current user and specified post" do
       expect( @user.favorites.find_by_post_id(@post.id) ).to eq(nil)
 
       post :create, { topic_id: @post.topic_id, post_id: @post.id }
 
       expect( @user.favorites.find_by_post_id(@post.id).class ).to eq(Favorite)
     end
   end
 
   describe '#destroy' do
     it "destroys the favorite for the current user and post" do
       favorite = @user.favorites.where(post: @post).create
       expect( @user.favorites.find_by_post_id(@post.id).class ).to eq(Favorite)
 
       delete :destroy, { topic_id: @post.topic_id, post_id: @post.id, id: favorite.id }
 
       expect( @user.favorites.find_by_post_id(@post.id) ).to eq(nil)
     end
   end
 end