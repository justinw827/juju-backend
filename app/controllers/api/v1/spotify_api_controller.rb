class Api::V1::SpotifyApiController < ApplicationController
  def self.refresh_token(current_user)

    # Check if the current user's access token needs to be refreshed
    if current_user.is_token_expired?

      # Refresh token request body
      body = {
        grant_type: "refresh_token",
        refresh_token: current_user.refresh_token,
        client_id: Rails.application.credentials.spotify[:client_id],
        client_secret: Rails.application.credentials.spotify[:client_secret]
      }

      byebug

      # Send request to Spotufy and update current_user with new access_token
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      current_user.update(access_token: auth_params["access_token"])
    else
      puts "Access token is still valid."
    end
  end

  def search
    @user = User.find_by(spotify_id: params["spotify_id"])

    self.class.refresh_token(@user)

    header = {
      Authorization: "Bearer #{@user["access_token"]}"
    }

    search_response = RestClient.get("https://api.spotify.com/v1/search?q=#{params["search_term"]}&type=track", header)
    search_params = JSON.parse(search_response)

    render json: search_params, status: :ok
  end

end # end class
