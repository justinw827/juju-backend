class Api::V1::UsersController < ApplicationController
  def create
    # If Spotify returns an error for login, redirect to homepage
    if params[:error]
      puts "LOGIN ERROR", params
      redirect_to "http://localhost:3001"
    else
      # Request body for post to get access token
      body = {
        grant_type: "authorization_code",
        code: params[:code],
        redirect_uri: Rails.application.credentials.spotify[:development][:redirect_uri],
        client_id: Rails.application.credentials.spotify[:client_id],
        client_secret: Rails.application.credentials.spotify[:client_secret]
      }

      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)

      auth_params = JSON.parse(auth_response.body)
    end

    header = {
      Authorization: "Bearer #{auth_params["access_token"]}"
    }

    user_response = RestClient.get("https://api.spotify.com/v1/me", header)

    user_params = JSON.parse(user_response.body)

    # Check if spotify_id from Spotify response exists in db.
    @user = User.find_or_create_by(spotify_id: user_params["id"])

    UserGroup.find_or_create_by(group_id: 1, user_id: @user.id)

    render json: { user: UserSerializer.new(@user)}, status: :accepted
  end

  # private
  #
  # def user_params
  #   params.require(:user).permit(:spotify_id)
  # end
end
