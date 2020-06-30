module UserHelper
  def button(user, friend)
    html = ''
    if friend && !(user.id.equal? current_user.id)
      html += "<button type='button' class='btn btn-primary'>
          <a rel='nofollow' data-method='post' href='/friendships?friend_id=#{user.id}'>Add Friend</a>
      </button>"
    end
    html
  end

  def post(user, friend)
    render @posts if !friend || (user.id.equal? current_user.id)
  end

  def post_title(user, friend)
    html = ''
    html = '<h3>Recent posts:</h3>' if !friend || (user.id.equal? current_user.id)
    html
  end
end
