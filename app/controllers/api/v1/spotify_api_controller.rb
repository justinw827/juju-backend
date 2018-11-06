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

      # Send request to Spotufy and update current_user with new access_token
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      current_user.update(access_token: auth_params["access_token"])
    else
      puts "Current user's access token is still valid."
    end
  end

  def search
    # auth_params["access_token"]

    # Change to auth_params when login works again
    access_token = "BQBt9LQGpbWOEM7WLeLkLReidELQUhY-xfbLh4pnHFJ_qs5vfcsDPbYEPdxY1FD6xfMqV1btO59qrjnoWQX7dm68RaBGxccDVrbSQpm7-S63fAYnXZ-EPrUWu7AKXr_X_0PpQzsT9LoLfLZ-VvuIvK-_EglaUqHWdlfTcHvpimH1KOa6XzPnj8DvCQ4E86b2LeH-Lo0RGeF8KtDLNifHBbK-qMADWp9JQ62cjwCWcLNswZVcbt3aG2D6mi-0yMav2w6U48FcU3b9bebdDio"

    header = {
      Authorization: "Bearer #{access_token}"
    }

    search_response = RestClient.get("https://api.spotify.com/v1/search?q=#{params["search_term"]}&type=track", header)
    search_params = JSON.parse(search_response)

    render json: search_params, status: :ok
  end

end # end class
