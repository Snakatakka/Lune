# gems
require 'ruby2d'

# files
require_relative 'FileManager.rb'

# classes
require_relative 'classes\Element.rb'
require_relative 'classes\Interactable.rb'

set title: "LuneMusicPlayer"
set width: 480
set height: 600
set background: "#574da3"

songs = get_songs("tracks")
currentSong = Music.new("tracks\\#{songs[0]}")
currentSong.play

paused = false

on :key_down do |input| # future note to self, don't put this in the update loop or else it'll break horrendously
    case input.key
    when "p" # keyboard controls for pausing
        paused = !paused
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
