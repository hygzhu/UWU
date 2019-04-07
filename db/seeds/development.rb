
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

#seed sources and songs
require 'json'

file = File.read "db/seeds/files/years4-7-2019.json"
data = JSON.parse(file)

data.each{ |year| 

    key, value = year.first

    value.each{ |source|

        songs = []

        source['songs'].each{ |song|
            tmp = Song.new(song_title: song["name"], 
                song_type:  song["type"],
                source: song["source"],
                url: song['url'])
            tmp.save

            songs.push(tmp)
        }

        source = Source.new(name: source['source'], year: key, period: source['period'])
        source.save

        songs.each{|song|
            source.add_song(song)
        }
    }    
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
    description: "Popular Playlist",
     name: "Popular Openings", 
     difficulty: "medium", 
     plays: 0 )
playlist = Playlist.find(2)
for i in [1361, 178, 1007, 50, 1700, 426, 544, 506, 2047, 2332, 188, 1905, 1811] do
    song = Song.find(i)
    playlist.add_song(song)
end

