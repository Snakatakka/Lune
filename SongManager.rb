require 'ruby2d'

def get_songs(file_path)
    files = Dir.new(file_path)
    songs = Dir.children(files)

    songs.each do | file |
        unless file.end_with?(".wav", ".ogg", ".mp3", ".qoa", ".xm", ".mod") 
            songs.delete(file) # ignores all non-audio files
        end
    end

    return songs
end