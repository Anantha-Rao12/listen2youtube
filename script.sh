folder_name="Youtube-songs"
if [ ! -d "$folder_name" ]; then
    mkdir -p $folder_name
fi

# skip the first line (header)
song_num=1
tail -n +2 data.csv | while IFS=, read -r song_name artist_name video_id; do
    echo "Processing Song no $song_num : $song_name by $artist_name..."
    song_title="$song_name ($artist_name)"
    url="https://www.youtube.com/watch?v=$video_id"
    if [ ! -f "$folder_name/$song_title.mp3" ]; then
        youtube-dl --extract-audio --audio-format mp3 --add-metadata -o "$folder_name/$song_title.%(ext)s" $url
    else
        echo "File $song_title.mp3 already exists, skipping download."
    fi
    echo ""
    song_num=$((song_num+1))
done
