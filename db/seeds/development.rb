
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


        new_source = Source.new(name: source['source'], year: key, period: source['period'].split.first)
        new_source.save


        source['songs'].each{ |song|
            new_source.songs.create(song_title: song["name"], 
                song_type:song["type"],
                source_name: song["source"],
                url: song['url'].sub('-NCBD1080', ''))
        }
    }    
}


#Seed premade playlists
users = User.order(:created_at).take(1)

#Openings for each season
Source.select(:year).map(&:year).uniq.each do |year|
    Source.select(:period).map(&:period).uniq.each do |season|

        #Create playlist
        playlist = users.first.playlists.new(
            description: "Opening Songs from #{season.capitalize} #{year}",
             name: "#{season.capitalize} #{year} Openings", 
             difficulty: "Normal", 
             plays: 0 )
        playlist.save

        openings= []
        #Select all sources in this year and season
        shows = Source.where("year = ? AND period = ?", year, season)
        shows.each do |show|
            song = show.songs.where("song_type = 'OP'")
            playlist.add_song(song)
        end
    end
end

#seed playlists
30.times do
    playlist =  User.find(2).playlists.new(
        description: "Test",
         name: "Test", 
         difficulty: "Easy", 
         plays: 0 )
    playlist.save
    for i in [1344, 1346] do
        song = Song.find(i)
        playlist.add_song(song)
    end
end

playlist = User.find(2).playlists.new(
    description: "Popular Playlist",
     name: "Popular Openings", 
     difficulty: "medium", 
     plays: 0 )
playlist.save
for i in [1361, 178, 1007, 50, 1700, 426, 544, 506, 2047, 2332, 188, 1905, 1811] do
    song = Song.find(i)
    playlist.add_song(song)
end

