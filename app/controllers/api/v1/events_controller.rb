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

    access_token = "BQCZzEzxQvGhN4jG7NGVYU38pC0SJqCTJqxscleVD-GwTaYdz6ofXHaLIWx3IC_J3D7qYjwOrCkLS6k13cRz7CbiywEwY_-RXy5mJ1dtHIKB094Hti36JCv06RnL5V_7nsvFTJN_sJfGbjnUCvhoVBTJwR4Em_kFB1wacyiEMC9nrZ3QTUqqBT9PrQ9uWmVr8Is4y15_uKoCKaOP7BWlE1CEQusV8qB4OJk1vLOGAjnUi-y4vB0hJIdggf15a63T1pQ9aPbhzXNj1qTZCKQ"

    postHeaders = {
      content_type: :json,
      accept: :json,
      Authorization: "Bearer #{access_token}"
    }

    # Temporary hard coded playlist id
    new_event = Event.create!(name: event_name, description: event_description, group_id: 1, playlist_id: "3qBswSHe4Hhjux8tpB4qGE")

    UserEvent.create!(user_id: user.id, event_id: new_event.id)

    spotify_response = RestClient.post('https://api.spotify.com/v1/playlists', postBody.to_json, headers=postHeaders)
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

    access_token = "BQCvje5QQ4ifzp0c2phn2CAKEXseVCwjq0f2n3idYJ6hVtGgCoBWg2RBNjdVsaQFaIBYlYIe0RNsjeL1qTWKzUaH8NP38nphWpni8EDkJAFNeA3w31DPkjPk47Uc8rHQpej70KAUSTQKGQpYIk5uXAuMa24OFfrbb0qBe7DjX7yhyjv-GU-vxzAZT53jCGOjuSJFaNyBC2uvzQus4p6TE-FonURcxGtu2lWHHE0nt6IM2EsGGWlF45k7tkAgyL1b2ABpZ2mJLPFq8LD3f7I"

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

  def search
    @events = Event.where("name like ?", "%#{params["search_term"]}%")

    @serializedEvents = @events.map do |event|
      EventSerializer.new(event)
    end

    render json: @serializedEvents, status: :ok
  end

  def add_user
    @user = User.find_by(spotify_id: params["spotify_id"])
    UserEvent.find_or_create_by!(user_id: @user.id, event_id: params["party_id"])
    @party = Event.find(params["party_id"])
    render json: { party: EventSerializer.new(@party) }, status: :ok
  end

end
