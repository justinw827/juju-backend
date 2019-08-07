# README

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
- First run Postgres on your computer
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

### Demo
[Video](https://www.youtube.com/watch?v=t55T6SIHUvU&feature=youtu.be)

Live Demo Coming Soon!!!
