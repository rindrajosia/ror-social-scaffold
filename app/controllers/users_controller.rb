class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  @users = []
  User.all.each do |user|
    if !friend?(user)
      @users << user
    end
  end
  @friends_confirmed = friends_confirmed
  @friends_inverse_confirmed = friends_inverse_confirmed
  @requests = friend_requests
  @invitations = friend_requests_by_me
end

def show
  @user = User.find(params[:id])
  @posts = @user.posts.ordered_by_most_recent
  if !friend?(@user)
    @friend = true
  end
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

def friend_requests_by_me
  friendship_array = []
    current_user.friendships.each do |friendship|
      if friendship.status == false
        friendship_array << friendship.friend
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

def friends_inverse_confirmed
  friendship_array = []
    current_user.friendships.each do |friendship|
      if friendship.status == true
        friendship_array << friendship
      end
    end
    friendship_array
end

def friends_confirmed
  friend = []
    current_user.inverse_friendships.each do |friendship|
      if friendship.status == true
        friend << friendship
      end
    end
    friend
end

def friend?(user)
  friends.include?(user)
end

end
