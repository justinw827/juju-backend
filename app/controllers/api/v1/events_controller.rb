class Api::V1::EventsController < ApplicationController
  def create
    user = User.find_by(spotify_id: params[:spotify_id])


    # Check user token is valid
    Api::V1::SpotifyApiController.refresh_token(user)

    access_token = user.access_token

    post_headers = {
      content_type: :json,
      accept: :json,
      Authorization: "Bearer #{access_token}"
    }

    # Get Party name and description from front end request body
    event_name = params["event_name"]
    event_description = params["event_description"]

    post_body = {
      "name": event_name,
      "description": event_description,
      "public": true
    }

    endpoint = 'https://api.spotify.com/v1/me/playlists'

    # Create a playlist on Spotify
    spotify_response = RestClient.post(endpoint, post_body.to_json, headers=post_headers)

    # Info on newly created playlist from Spotify
    playlist = JSON.parse(spotify_response.body)

    # Temporary hard coded playlist id
    new_event = Event.create!(name: event_name, description: event_description, group_id: 1, playlist_id: playlist["id"], host_id: user.id)

    UserEvent.create!(user_id: user.id, event_id: new_event.id)

    render json: { party: EventSerializer.new(new_event) }, status: :ok
  end

  def show
    @party = Event.find(params[:id])

    byebug

    endpoint = "https://api.spotify.com/v1/playlists/#{@party.playlist_id}"

    RestClient.get(endpoint)

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

    # Get the active party of the user
    @party = Event.find(params[:id])
    playlist_id = @party.playlist_id
    # playlist_id = "0oGyb8ShBfcdkTkcAtv8uA"

    @user = User.find_by(id: @party.host_id)

    # Check if user's access token needs to be refreshed
    Api::V1::SpotifyApiController.refresh_token(@user)

    access_token = @user.access_token
    # access_token = "BQB6k1XuejH_JgPoksvOrAiLOZ-weiHSvU0eyZhJUQKUEau6Us5qHALcwXdbR8USxCF2AucLnIWPe-6dWO2sKreIsylDP_KUDqG26LesfbPRjzrdtc_NtlET5j2-mDeMQby6qGAZVTQyfN5lTO8SyNbGO-Pu6VvbJG2DDHgoUrVrdHJvM9lkeLuhJnY1cdtgQOg-p-cgU5ET3M4ufLmUVsU5MYhdExkvH4HFtFFUX_9KyjadcKwTt9Lw5sk-ce2KpWOCINFxz7dblTHiklQ"

    header = {
      Authorization: "Bearer #{access_token}"
    }

    # The search query
    url = {
      uris: params["url"]
    }

    endpoint = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks?#{url.to_query}"


    return_status = :ok

    begin
      post_response = RestClient.post(endpoint, {}, header)
    rescue StandardError => e # Add custom exception for 401 Unauthorized and 403 Forbidden
      return_status = :unauthorized
    end

    render json: @party, status: return_status
  end

  def search
    # Find parties that contain the search term in their name as a substring
    @events = Event.where("name like ?", "%#{params["search_term"]}%")

    # Serialize the found parties
    @serializedEvents = @events.map do |event|
      EventSerializer.new(event)
    end

    render json: @serializedEvents, status: :ok
  end

  def add_user
    # Find the current user and create a new relationship between the user and the party
    @user = User.find_by(spotify_id: params["spotify_id"])
    UserEvent.find_or_create_by!(user_id: @user.id, event_id: params["party_id"])

    # Find the party and return the updated version to front end
    @party = Event.find(params["party_id"])
    render json: { party: EventSerializer.new(@party) }, status: :ok
  end

end
