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
songID = 0
currentSong = Music.new("tracks\\#{songs[songID]}")
currentSong.play

paused = false

on :key_down do |input| # get input from user
    case input.key
    when "p" # keyboard controls for pausing
        paused = !paused
    when "r" # reload music
        currentSong.pause
        songs = get_songs("tracks")
        currentSong = Music.new("tracks\\#{songs[0]}")
        currentSong.play

    when "right"
        currentSong.stop
        unless songID + 1 >= songs.length
            songID += 1
            currentSong = Music.new("tracks\\#{songs[songID]}")
        else
            songID = 0
            currentSong = Music.new("tracks\\#{songs[songID]}")
        end
        currentSong.play
    
    when "left"
        currentSong.stop
        unless songID - 1 < 0
            songID -= 1
            currentSong = Music.new("tracks\\#{songs[songID]}")
        else
            songID = songs.length - 1
            currentSong = Music.new("tracks\\#{songs[songID]}")
        end
        currentSong.play

    when "escape" # quit
        close

    else
        puts input.key
    end
end

update do
    if paused
        currentSong.pause
    else
        currentSong.resume
    end
end

show
