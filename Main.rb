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

def change_song(new_song_id)
    $current_song.stop
    $current_song_title.remove
    $song_id = new_song_id
    $current_song = Music.new("tracks\\#{$songs[$song_id]}")
    $current_song_title = Text.new("#{$songs[$song_id].slice(0..($songs[$song_id].index('.') - 1))}", z: 10)
    $current_song_title.add
    $current_song.play
end

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
    2, # z_index
    (main_inner.get_attribute("height") - 10), # height
    (main_inner.get_attribute("width") - 10), # width
    0, # size
    '#C9EEEF' # color
)

# user input
# -----------------------------------------------------------------------------------------------------------------

paused = false

def random_song() # this used to be shuffling but i gave up on that :sunglasses_cool:
    randomized_song = rand(0..($songs.length - 1))
    
    while randomized_song == $song_id
        randomized_song = rand(0..($songs.length - 1))
    end
    
    change_song(randomized_song)
end

def reload()
    $songs = get_songs("tracks")
    change_song(0)
end

def cycle_forward()
    unless $song_id + 1 >= $songs.length
        change_song($song_id + 1)
    else
        change_song(0)
    end
end

def cycle_backward()
    unless $song_id - 1 < 0
        change_song($song_id - 1)
    else
        change_song($songs.length - 1)
    end
end


on :key_down do |input| # keyboard input
    case input.key
    when "p" # pause song
        paused = !paused
    when "s" # shuffle song
        shuffle()
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