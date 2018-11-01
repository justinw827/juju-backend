class SpotifyAPIAdapter < ApplicationController
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

      # Send request to Spotufy and update current_user with new access_token
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      current_user.update(access_token: auth_params["access_token"])
    else
      puts "Current user's access token is still valid."
    end
  end
end # end class
