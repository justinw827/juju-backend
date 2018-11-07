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

    access_token = "BQARiPk7fm30-ZRHAhBOwohG0HW6J__WcL4Ht8TTbLAsuEsWEaFcDBxZLJ_Zynl0fHldZ3vXILWc_DVihY_-MnpXzCF2gljoLblCIVpie97GSf-qIsdGlhb0HD7gI9-d86mcjqx_g_Buc9n-ckPMXn3aXngRH6M3gvh_NJ3NyJUfdtsoXfIrEjCtxFJ4dc6ehJZnlfvH0_5D6lQVas0XpT4t3XWy8YaIeLA4C4SZ7rx8BMWNyu82-_UZbPFeqLuazBSbNHNrSl5Gwi8SUPI"

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

    access_token = "BQARiPk7fm30-ZRHAhBOwohG0HW6J__WcL4Ht8TTbLAsuEsWEaFcDBxZLJ_Zynl0fHldZ3vXILWc_DVihY_-MnpXzCF2gljoLblCIVpie97GSf-qIsdGlhb0HD7gI9-d86mcjqx_g_Buc9n-ckPMXn3aXngRH6M3gvh_NJ3NyJUfdtsoXfIrEjCtxFJ4dc6ehJZnlfvH0_5D6lQVas0XpT4t3XWy8YaIeLA4C4SZ7rx8BMWNyu82-_UZbPFeqLuazBSbNHNrSl5Gwi8SUPI"

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
