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

    byebug
    # Temporary hard coded playlist id
    new_event = Event.create!(name: event_name, description: event_description, group_id: 1, playlist_id: "3qBswSHe4Hhjux8tpB4qGE")

    UserEvent.create!(user_id: user.id, event_id: new_event.id)

    # spotify_response = RestClient.post('https://api.spotify.com/v1/playlists', postBody.to_json, headers=postHeaders)
    render json: { event: EventSerializer.new(new_event) }, status: :ok
  end

  def get_all_events
    @events = Event.all

    @newEvents = @events.map do |event|
      EventSerializer.new(event)
    end

    render json: @newEvents, status: :ok
  end
end
