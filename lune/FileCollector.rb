def get_tracks(file_path)
    files = Dir.new(file_path)
    songs = Dir.children(files)

    songs.each do | file |
        unless file.end_with?(".wav", ".ogg", ".mp3")
            songs.delete(file)
        end
    end

    return songs
end