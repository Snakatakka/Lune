# gems
require 'ruby2d'

# files
require_relative 'SongManager.rb'

# classes
require_relative 'classes\Element.rb'

set title: "LuneMusicPlayer"
set width: 480
set height: 600
set background: "#574da3"

songs = get_songs("tracks")
song_id = 0
current_song = Music.new("tracks\\#{songs[song_id]}")
current_song_title = Text.new("#{songs[song_id]}")
current_song.play

# chat what should i call this element

container = Element.new("rectangle", 240, 225, 350, 400)

paused = false

on :key_down do |input| # get input from user
    case input.key
    when "p" # keyboard controls for pausing
        paused = !paused

    when "r" # reload app
        current_song.stop
        current_song_title.remove
        songs = get_songs("tracks")
        current_song = Music.new("tracks\\#{songs[0]}")
        songs = get_songs("tracks")
        current_song_title.add
        current_song.play

    when "right" # cycle song forward
        current_song.stop
        current_song_title.remove
        unless song_id + 1 >= songs.length
            song_id += 1
            current_song = Music.new("tracks\\#{songs[song_id]}")
            current_song_title = Text.new("#{songs[song_id]}")
        else
            song_id = 0
            current_song = Music.new("tracks\\#{songs[song_id]}")
            current_song_title = Text.new("#{songs[song_id]}")
        end
        current_song_title.add
        current_song.play

    when "left" # cycle song backwards
        current_song.stop
        current_song_title.remove
        unless song_id - 1 < 0
            song_id -= 1
            current_song = Music.new("tracks\\#{songs[song_id]}")
            current_song_title = Text.new("#{songs[song_id]}")
        else
            song_id = songs.length - 1
            current_song = Music.new("tracks\\#{songs[song_id]}")
            current_song_title = Text.new("#{songs[song_id]}")
        end
        current_song_title.add
        current_song.play
    when "escape" # quit
        close
    end
end

update do

    if paused
        current_song.pause
    else
        current_song.resume
    end
end

show
