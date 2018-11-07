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
    access_token = "BQARiPk7fm30-ZRHAhBOwohG0HW6J__WcL4Ht8TTbLAsuEsWEaFcDBxZLJ_Zynl0fHldZ3vXILWc_DVihY_-MnpXzCF2gljoLblCIVpie97GSf-qIsdGlhb0HD7gI9-d86mcjqx_g_Buc9n-ckPMXn3aXngRH6M3gvh_NJ3NyJUfdtsoXfIrEjCtxFJ4dc6ehJZnlfvH0_5D6lQVas0XpT4t3XWy8YaIeLA4C4SZ7rx8BMWNyu82-_UZbPFeqLuazBSbNHNrSl5Gwi8SUPI"

    header = {
      Authorization: "Bearer #{access_token}"
    }

    search_response = RestClient.get("https://api.spotify.com/v1/search?q=#{params["search_term"]}&type=track", header)
    search_params = JSON.parse(search_response)

    render json: search_params, status: :ok
  end

end # end class
