class Api::V1::LoginController < ApplicationController
  def login
    query_params = {
      client_id: Rails.application.credentials.spotify[:client_id],
      response_type: "code",
      redirect_uri: Rails.application.credentials.spotify[:development][:redirect_uri],
      scope: "user-read-private user-read-playback-state playlist-modify-private playlist-modify-public user-read-playback-state user-read-currently-playing user-modify-playback-state",
      show_dialog: true
    }

    url = "https://accounts.spotify.com/authorize/"


    redirect_to "#{url}?#{query_params.to_query}"
  end
end

# user-read-playback-state playlist-modify-private playlist-modify-public user-read-playback-state user-read-currently-playing user-modify-playback-state
