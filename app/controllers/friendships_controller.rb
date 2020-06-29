class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash.notice = 'Added friend.'
    else
      flash.alert = 'Unable to add friend.'
    end
    redirect_to users_path
  end

  def update
    @friendship = current_user.inverse_friendships.find(params[:id])
    flash.notice = @friendship.update(status: true) ? 'Confirmed.' : 'Unable to Confirme.'

    redirect_to users_path
  end

  def destroy
    @friendship = current_user.inverse_friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = 'Rejected Invitation.'
    redirect_to users_path
  end
end
