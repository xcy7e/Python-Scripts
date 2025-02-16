#!/bin/bash
# Clear ABS-metadata (automatically and safe - only deletes mp3-files if no FFMPEG-process is running!)

FFMPEG_PROCS=$(ps -ef | grep ffmpeg | wc -l)

# Output for the logfile
current_date_time="`date "+%Y-%m-%d %H:%M:%S"`";
echo -en "\n------------------------------------------------------------------\n$current_date_time\n"


if [ "$FFMPEG_PROCS" -lt "2" ]; then
    echo -e "\e[92mStart automatic metadata-cleanup:\e[0m"
    sudo find /usr/share/audiobookshelf/metadata/cache/items/ -type f -iname *.mp3 -delete
else
    echo -e "\e[91m$FFMPEG_PROCS ffmpeg-processes are still running! Cancel!\e[0m"
fi
