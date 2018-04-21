# convert 3gp to mp3
read -r input
ffmpeg -i $input -c:a libmp3lame "${input: :-3}mp3"
