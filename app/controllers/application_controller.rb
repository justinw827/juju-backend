class ApplicationController < ActionController::API
  # before_action :authorized

  def auth_header
    request.headers['Authorization'] # Bearer <spotify_id>
  end

  def get_id
    if auth_header
      spotify_id = auth_header.split(' ')[1] #[Bearer, <spotify_id>]
    end
  end

  def current_user
    if get_id()
      spotify_id = get_id
      @user = User.find_by(spotify_id: spotify_id)
    else
      nil
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
