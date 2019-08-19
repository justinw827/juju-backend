# README

Imagine you're listening to music with some friends having fun, but then you think of a song you want to play. Now you have to bother your friend and ask them to play the song for you. Wouldn't it be nice if you could just queue up the song next yourself? Now you can with Juju! One person, the one playing the music, just has to create a party on the app, which will create a playlist in your Spotify account. Then just play the music from that playlist, and now all your friends can join your party, and add songs from their own devices! No need to bother your friend to play a song next. Just search your song through the app, add it to the queue, and your song will be up next! Listening to music has never been easier.

### Demo
[Video](https://www.youtube.com/watch?v=t55T6SIHUvU&feature=youtu.be)

Live Demo Coming Soon!!!

### Ruby Version:
- 2.5.1

After cloning the repository, you'll have to
* Install bundle if you do not have it yet. In your console run
```console
gem install bundle
```
* Then install the gems required for this project
```console
bundle
```

### How to setup the database:
- First, ensure Postgres is running on your computer
- Next in your console run
```console
rails db:create && rails db:migrate
```

### How to run:
```console
rails s
```
- Front end runs under assumption Rails server is on port 3000
- Rails server runs under assumption front end is running on port 3001

### Description
Back end Rails server used to store User and Party data created in [juju-frontend](https://github.com/justinw827/juju-frontend).
Utilizes the [Spotify Web API](https://developer.spotify.com/documentation/web-api/)
Application links with user's Spotify accounts using OAuth 2.0 specifications. Authentication of user
is handled by Spotify, thus a Spotify account is required to run application.

Full application (front end & back end) allows you to log in with your Spotify account, linking your account with the app. Once logged in, you can create a party, which also creates a Spotify playlist in your account. Other people can join your party and add songs to your playlist, making the playlist a queue of songs. Songs are added to the queue (playlist) by searching for a song in the search bar, and clicking 'Add to Queue', adding the song to the active party's playlist.
