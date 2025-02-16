## AUTOMATIC M4B-CONVERTING USING ABS BUILTIN TOOLS
### Requirements:
- bash
- python (with selenium & geckodriver for headless firefox)
- a txt-file with LibraryItemIds (one ID per line, dashes yes; but no quotes whatsoever)
 
### HOW TO USE
The bash-scripts are only there to control automatism for the python script. You may just need the python script for your own setup, actually.

1. Configure your custom values and paths in all scripts (you might want to edit the m4b-convert-button text in the .py-file according to your language!)
2. Create a txt-file with all libraryItemIds (you can retrieve them from an abs-backup sqlite-file
3. Start `m4b_convert_mgr.sh` (e.g. from a cronjob)

### crons.txt
I put my cronjob configuration (`cron.txt`) in here to give some ideas on how you can use these scripts to build a perfect cycle of converting and cleanup for your existing library.
The only thing you have to do yourself is to gather the library item IDs. (I put an example query for the sqlite-db in `query.txt`)

### Free metadata cache space automatically (some personal recommendations)
I strongly recommend to clear the metadata cache directory (I only delete the backuped `.mp3`-files) on a regular basis (e.g. cronjob)
I personally run the m4b-conversion from 03:15-14:45 and from 15:15-23:45 and clear the metadata-cache items 2 times in between those timespans (at the very end) if (and only IF) no more ffmpeg-processes are running at that time.
In the night, there is time for the ABS Backup at 01:30 to avoid any interruption

---

**Use at YOUR OWN RISK!**

If the M4B converting works but result in invalid files, you may have no backup mp3's if you automatically clear the metadata as set up in the examples.
