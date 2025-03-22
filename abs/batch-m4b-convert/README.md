## Automatically convert all audiobooks to m4b using builtin ABS-tools
[This script](https://github.com/xcy7e/Python-Scripts/blob/master/abs/batch-m4b-convert/scripts/abs_m4bconvert.py) starts an m4b-conversion for a single audiobook through the Audiobookshelf's Webinterface using *selenium*. The shell scripts on the other hand simply control the processes and build a "cycle flow" to process all audiobooks chosen for m4b-Convert.

### Requirements
- bash
- python (with selenium & geckodriver for headless firefox)
- a txt-file with LibraryItemIds (one ID per line, dashes yes; but no quotes whatsoever)

### Install requirements
```bash
pip3 install selenium
pip3 install webdriver-manager 
```

### HOW TO USE
The bash-scripts control automatism for the python script. You may just want the python script to use it in whatever environment/automatism configuration.

1. Configure your custom values and paths in all scripts
2. Create a txt-file with all `libraryItemIds` (you can retrieve them from an abs-backup sqlite-file)
3. Start `m4b_convert_mgr.sh` (e.g. from a cronjob)

---

### Cronjob examples - `cron.txt`
I put my cronjob configuration ([`cron.txt`](https://github.com/xcy7e/Python-Scripts/blob/master/abs/batch-m4b-convert/examples/cron.txt)) in here to give some ideas on how you can use these scripts to build a perfect cycle of converting and cleanup for your existing library.
The only thing you have to do yourself is to gather the library item IDs. (I put an example query for the sqlite-db in `query.txt`)

### How to get the library item IDs?
I put an example query in [`query.txt`](https://github.com/xcy7e/Python-Scripts/blob/master/abs/batch-m4b-convert/examples/query.txt) for the `.sqlite`-database to get `library_item.id`'s from audiobooks that still have mp3-files in it, ordered from large to small.
You may need different conditions based on your current state of the overall converting process and favors.

### Free metadata cache space automatically (some personal recommendations)
I would recommend<sup>1</sup> to clear the metadata cache directory on a regular basis (e.g. cronjob) (I only delete the backup'ed `.mp3`-files).
See [`cron.txt`](https://github.com/xcy7e/Python-Scripts/blob/master/abs/batch-m4b-convert/examples/cron.txt) for possible "slots" between the auto m4b-converting to use for metadata cleanup.

---

## Important notes

**<sup>1</sup>Use at YOUR OWN RISK!**

If the M4B converting works but result in invalid files, you may have no backup mp3's if you automatically clear the metadata as set up in the examples.

