class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @ft = Friendship.new
    @ft.user_id = params[:friend_id]
    @ft.friend_id = current_user.id

    if @friendship.save && @ft.save
      flash.notice = 'Added friend.'
    else
      flash.alert = 'Unable to add friend.'
    end
    redirect_to users_path
  end

  def update
    @ft = Friendship.where(user_id: current_user.id, friend_id: params[:id])

    @friendship = current_user.inverse_friendships.find(params[:id])
    flash[:notice] = if @friendship.update(status: true) && @ft.update(status: true)
                       'Confirmed'
                     else
                       'Unable to comfirm'
                     end
    redirect_to users_path
  end

  def destroy
    @ft = Friendship.where(user_id: current_user.id, friend_id: params[:id])

    @friendship = current_user.inverse_friendships.find(params[:id])

    flash[:notice] = @friendship.destroy && @ft.destroy ? flash[:notice] = 'Rejected' : 'Unable to reject'

    redirect_to users_path
  end
end
