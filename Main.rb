# gems
require 'ruby2d'

# files
require_relative 'SongManager.rb'

# classes
require_relative 'classes\Element.rb'

# setup
# -----------------------------------------------------------------------------------------------------------------

set title: "LuneMusicPlayer"
set width: 480
set height: 600
set background: "#4AABFF"

$songs = get_songs("tracks")
$song_id = 0
$current_song = Music.new("tracks\\#{$songs[$song_id]}")
$current_song_title = Text.new("#{$songs[$song_id].slice(0..($songs[$song_id].index('.') - 1))}", z: 10) # this is incomprehensible L_L
autoplay = false


$current_song.play



# user interface
# -----------------------------------------------------------------------------------------------------------------

main_outer = Element.new(
    "rectangle", # type
    240, # x_pos
    200, # y_pos
    0, # z_index
    350, # height
    450, # width
    0, # size
    '#FFFFFF' # color
)

main_inner = Element.new(
    "rectangle", # type
    (main_outer.get_attribute("x_pos")), # x_pos
    (main_outer.get_attribute("y_pos")), # y_pos
    1, # z_index
    (main_outer.get_attribute("height") - 10), # height
    (main_outer.get_attribute("width") - 10), # width
    0, # size
    '#258FEB' # color
)

main_screen = Element.new(
    "rectangle", # type
    (main_outer.get_attribute("x_pos")), # x_pos
    (main_outer.get_attribute("y_pos")), # y_pos
    1, # z_index
    (main_inner.get_attribute("height") - 10), # height
    (main_inner.get_attribute("width") - 10), # width
    0, # size
    '#C9EEEF' # color
)

# user input
# -----------------------------------------------------------------------------------------------------------------

paused = false

def reload()
    $current_song.stop
    $current_song_title.remove
    $songs = get_songs("tracks")
    $current_song = Music.new("tracks\\#{$songs[0]}")
    $songs = get_songs("tracks")
    $current_song_title.add
    $current_song.play
end

def cycle_forward()
    $current_song.stop
    $current_song_title.remove
    unless $song_id + 1 >= $songs.length
        $song_id += 1
        $current_song = Music.new("tracks\\#{$songs[$song_id]}")
        $current_song_title = Text.new("#{$songs[$song_id].slice(0..($songs[$song_id].index('.') - 1))}")
    else
        $song_id = 0
        $current_song = Music.new("tracks\\#{$songs[$song_id]}")
        $current_song_title = Text.new("#{$songs[$song_id].slice(0..($songs[$song_id].index('.') - 1))}")
    end
    $current_song_title.add
    $current_song.play
end

def cycle_backward()
    $current_song.stop
    $current_song_title.remove
    unless $song_id - 1 < 0
        $song_id -= 1
        $current_song = Music.new("tracks\\#{$songs[$song_id]}")
        $current_song_title = Text.new("#{$songs[$song_id].slice(0..($songs[$song_id].index('.') - 1))}")
    else
        $song_id = $songs.length - 1
        $current_song = Music.new("tracks\\#{$songs[$song_id]}")
        $current_song_title = Text.new("#{$songs[$song_id].slice(0..($songs[$song_id].index('.') - 1))}")
    end
    $current_song_title.add
    $current_song.play
end


on :key_down do |input| # get input from user
    case input.key
    when "p" # keyboard controls for pausing
        paused = !paused
    
    when "s" # shuffle song
        # TODO: add shuffle function

    when "r" # reload app
        reload()

    when "right" # cycle song forward
        cycle_forward()

    when "left" # cycle song backwards
        cycle_backward()

    when "escape" # quit
        close
    end
end

# update loop
# -----------------------------------------------------------------------------------------------------------------

update do
    if paused
        $current_song.pause
    else
        $current_song.resume
    end
end

show
