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
    access_token = "BQCvje5QQ4ifzp0c2phn2CAKEXseVCwjq0f2n3idYJ6hVtGgCoBWg2RBNjdVsaQFaIBYlYIe0RNsjeL1qTWKzUaH8NP38nphWpni8EDkJAFNeA3w31DPkjPk47Uc8rHQpej70KAUSTQKGQpYIk5uXAuMa24OFfrbb0qBe7DjX7yhyjv-GU-vxzAZT53jCGOjuSJFaNyBC2uvzQus4p6TE-FonURcxGtu2lWHHE0nt6IM2EsGGWlF45k7tkAgyL1b2ABpZ2mJLPFq8LD3f7I"

    header = {
      Authorization: "Bearer #{access_token}"
    }

    search_response = RestClient.get("https://api.spotify.com/v1/search?q=#{params["search_term"]}&type=track", header)
    search_params = JSON.parse(search_response)

    render json: search_params, status: :ok
  end

end # end class
