class Api::V1::EventsController < ApplicationController
  def create
    user = User.find_by(spotify_id: params[:spotify_id])

    event_name = params["event_name"]
    event_description = params["event_description"]

    postBody = {
      "name": event_name,
      "description": event_description,
      "public": true
    }

    postHeaders = {
      content_type: :json,
      accept: :json,
      Authorization: "Bearer #{user.access_token}"
    }

    # Temporary hard coded playlist id
    new_event = Event.create!(name: event_name, description: event_description, group_id: 1, playlist_id: "3qBswSHe4Hhjux8tpB4qGE")

    UserEvent.create!(user_id: user.id, event_id: new_event.id)

    # spotify_response = RestClient.post('https://api.spotify.com/v1/playlists', postBody.to_json, headers=postHeaders)
    render json: { event: EventSerializer.new(new_event) }, status: :ok
  end

  def show
    @party = Event.find(params[:id])

    render json: { party: EventSerializer.new(@party) }, status: :ok
  end

  def get_all_events
    @events = Event.all

    @newEvents = @events.map do |event|
      EventSerializer.new(event)
    end

    render json: @newEvents, status: :ok
  end

  def add_song
    @party = Event.find(params[:id])

    access_token = "BQCatGEW_BOpQstkgY2iU_2iIfUxpag1ZO4ABQqjqcbL7HWdjVOw8W3i681yb96TIm5hq5SPEo0K16iGAiwcMKUOcB_Xr-bXleDeHxcs8NYbg9t4hIQe4e8GnND5AP5HNR57gOKmCirmTLcVPJ72zszjFtFK4bjXN6o529fSJlPMjlOTU6tNtTvKbUUeyAqHXH2LHFGLsmQ-0E9yqmoyQwakUwl10RNPfjiHdVC0ZIG2cnnlDrGXRnxLSEfWHQpnNkWs2qrqOAifLRDNURc"

    header = {
      Authorization: "Bearer #{access_token}"
    }

    url = {
      uris: params["url"]
    }
    endpoint = "https://api.spotify.com/v1/playlists/#{@party.playlist_id}/tracks?#{url.to_query}"
    post_response = RestClient.post(endpoint, {}, header)

    render json: @party, status: :ok
  end
end
