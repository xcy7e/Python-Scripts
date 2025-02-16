#!/bin/bash

# Starts m4b-converting py-script if enough CPUs are free

# USAGE:
#
# Test-Mode (keeps IDs in txt-file):
# ./m4b_convert_mgr.sh 1
#
# Regular-Mode:
# ./m4b_convert_mgr.sh


ID_FILE="ids.txt"	# path to txt-file with libraryItemIds
IDS_LEFT=$(wc -l "$ID_FILE")
if [ "$IDS_LEFT" -lt "1" ];then
    echo -e "\e[91mAll IDs processed."
    return
fi

# (I recommend to keep 1 CPU free at all time, so on 8 CPUs i have max=7)
MAX_PROCS=7
# Keep min 5-7GB free space on abs metadata drive
MIN_FREESPACE_BYTES=7120000000


USED_CPUS=$(ps -ef | grep ffmpeg | wc -l)
USED_CPUS=$((USED_CPUS-1))
FREE_SPACE_BYTES=$(df -khB1 /usr/share/audiobookshelf/metadata | tail -n1 | awk '{print $4}')

TEST_MODE="$1"

function start_m4bconvert () {
    echo "Start converting:"

    # Get libraryItemId from txt-file
    LIBI_ID=$(head -n 1 "$ID_FILE")

    # Remove ID from txt-file
    if [ "$TEST_MODE" == "1" ]; then
        echo -e "\e[94mTest-Mode: ID kept in txt-file\e[0m"
    else
        tail -n +2 "$ID_FILE" > "$ID_FILE.tmp" && mv "$ID_FILE.tmp" "$ID_FILE"
    fi

    echo -e "Library Item: \e[92m$LIBI_ID\e[0m"
    python3 abs_m4bconvert.py "$LIBI_ID"

    echo -e "\e[1mJob done!\e[0m"
    return
}

# Print datetime for the cronjob log
current_date_time="`date "+%Y-%m-%d %H:%M:%S"`";
echo -en "\n------------------------------------------------------------------\n$current_date_time\n"


# Check free CPUs
if [ "$USED_CPUS" -lt "$MAX_PROCS" ]; then
    # Check free Disk-Space
    if [ "$FREE_SPACE_BYTES" -gt "$MIN_FREESPACE_BYTES" ]; then
        start_m4bconvert
    else
        echo "Not enough disk space ($FREE_SPACE_BYTES bytes left) ($MIN_FREESPACE_BYTES bytes minimum)"
        return
    fi
else
    echo "Max processes reached. ($USED_CPUS/$MAX_PROCS)"
    return
fi
