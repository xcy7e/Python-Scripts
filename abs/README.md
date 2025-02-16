## AUTOMATIC M4B-CONVERTING USING ABS BUILTIN TOOLS
### Requirements:
- bash
- python (with selenium & headless geckodriver)
- a txt-file with LibraryItemIds (one ID per line, dashes yes; but no quotes whatsoever)
 
### HOW TO USE
1. Configure your custom values in both scripts (you might want to edit the m4b-convert-button text in the .py-file according to your language!)
2. Create a txt-file with all libraryItemIds (you can retrieve them from an abs-backup sqlite-file
3. Start `m4b_convert_mgr.sh` (e.g. from a cronjob) 

### Free metadata cache space automatically (some personal recommendations)
I strongly recommend to clear the metadata cache directory (I only delete the backuped `.mp3`-files) on a regular basis (e.g. cronjob)
I personally run the m4b-conversion from 03:15-14:45 and from 15:15-23:45 and clear the metadata-cache items 2 times in between those timespans (at the very end) if (and only IF) no more ffmpeg-processes are running at that time.
In the night, there is time for the ABS Backup at 01:30 to avoid any interruption
