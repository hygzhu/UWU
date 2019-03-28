
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

# Song.create!(song_title: "Chiisana Boukensha", 
#     song_artist: "Various",
#     song_type: "ED",
#     source: "Konosuba",
#     source_period: 20161,
#     url: "https://openings.moe/video/KonoSubarashiiSekaiNiShukufukuO!-ED01-NCBD.mp4")
    

# Song.create!(song_title: "Ouchi ni Kaeritai", 
#     song_artist: "Various",
#     song_type: "ED",
#     source: "Konosuba S2",
#     source_period: 20161,
#     url: "https://openings.moe/video/KonoSubarashiiSekaiNiShukufukuO!2-ED01-NCBD.mp4")
    
    
# 99.times do |n|
#     Song.create!(song_title: "Place holder", 
#         song_artist: "Various",
#         song_type: "OP",
#         source: "Test sauce",
#         source_period: 20161,
#         url: "https://openings.moe/video/KonoSubarashiiSekaiNiShukufukuO!2-ED01-NCBD.mp4")
# end    

#seed songs
require 'json'

file = File.read "db/seeds/20190324.json"
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

#seed playlists
users = User.order(:created_at).take(1)
# 20.times do
#   description = Faker::Lorem.sentence(5)
#   users.each { |user| user.playlists.create!(description: description, name: "test playlist", difficulty: "easy", plays: 0 ) }
# end

users.first.playlists.create!(
    description: "testddddd",
     name: "Konosuba", 
     difficulty: "easy", 
     plays: 0 )

playlist = Playlist.find(1)

for i in [1346, 1345, 1344, 1343] do
    song = Song.find(i)
    playlist.add_song(song)
end

for j in 2..30 do
    name = Faker::Company.bs
    description = Faker::Lorem.sentence(5)
    users.last.playlists.create!(description: description, name: "#{name} playlist", difficulty: "easy", plays: 0 )

    playlist = Playlist.find(j)

    for i in [1346, 1345, 1344, 1343] do
        song = Song.find(i)
        playlist.add_song(song)
    end
end