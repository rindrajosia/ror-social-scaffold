class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  @users = []
  User.all.each do |user|
    if !friend?(user)
      @users << user
    end
  end
  @requests = friend_requests
end

def show
  @user = User.find(params[:id])
  @posts = @user.posts.ordered_by_most_recent
end

def friend_requests
  friendship_array = []
    current_user.inverse_friendships.each do |friendship|
      if friendship.status == false
        friendship_array << friendship
      end
    end
    friendship_array
end

def friends
  friendship_array = []
  friend = []
    current_user.friendships.each do |friendship|
      friendship_array << friendship.friend
    end
    current_user.inverse_friends.each do |user|
      friend << user
    end
    friendship_array + friend
end

def friend?(user)
  friends.include?(user)
end
end
