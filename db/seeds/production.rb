require 'json'

# file = File.read "db/seeds/20190324.json"
# data = JSON.parse(file)

# data.each{ |song| 

#     song["song"] = {"title"=> "", "artist"=> "" } if song["song"].nil?

#     Song.create!(song_title: song["song"]["title"], 
#         song_artist: song["song"]["artist"],
#         song_type:  song["title"],
#         source: song["source"],
#         source_period: 0,
#         url: "https://openings.moe/video/" + song["file"] + ".mp4")
        
# }

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