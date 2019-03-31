
User.create!(name:  "Test",
    email: "test@test.com",
    password:              "123456",
    password_confirmation: "123456",
    admin:     true,
    activated: true,
    activated_at: Time.zone.now)

User.create!(name:  "Test2",
    email: "test2@test.com",
    password:              "123456",
    password_confirmation: "123456",
    admin:     false,
    activated: true,
    activated_at: Time.zone.now)

30.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
     email: email,
     password:              password,
     password_confirmation: password,
     activated: true,
     activated_at: Time.zone.now)
end

#seed songs
require 'json'

file = File.read "db/seeds/op_moe_20190324.json"
data = JSON.parse(file)

data.each{ |song| 

    song["song"] = {"title"=> "", "artist"=> "" } if song["song"].nil?

    Song.create!(song_title: song["song"]["title"], 
        song_artist: song["song"]["artist"],
        song_type:  song["title"],
        source: song["source"],
        source_period: 0,
        url: "https://openings.moe/video/" + song["file"] + ".mp4")
        
}

file = File.read "db/seeds/themes_moe_20190330.json"
data = JSON.parse(file)

data.each{ |song| 
    
    Song.create!(song_title: "", 
        song_artist: "",
        song_type:  song["type"],
        source: song["source"],
        source_period: 0,
        url: song["url"])
        
}

#seed playlists
users = User.order(:created_at).take(1)

users.first.playlists.create!(
    description: "Test",
     name: "Test", 
     difficulty: "Easy", 
     plays: 0 )
playlist = Playlist.find(1)
for i in [1344, 1346] do
    song = Song.find(i)
    playlist.add_song(song)
end

users.first.playlists.create!(
    description: "Popular Opening Songs from Winter 2016",
     name: "Winter 2016 Popular Openings", 
     difficulty: "medium", 
     plays: 0 )
playlist = Playlist.find(2)
for i in [1361, 178, 1007, 50, 1700, 426, 544, 506, 2047, 2332, 188, 1905, 1811] do
    song = Song.find(i)
    playlist.add_song(song)
end

