#!/usr/bin/env bash
#note that this is only a backup copy of the file used to deploy on the server
unzip videosummary-1.0-SNAPSHOT.zip
rm *.zip
cp chromedriverLinux videosummary-1.0-SNAPSHOT/
cp chromedriverLinux videosummary-1.0-SNAPSHOT/bin
service mysql start
Xvfb :10 -ac &
./videosummary-1.0-SNAPSHOT/bin/videosummary -Dhttp.port=80 -Dplay.evolutions.db.default.autoApply=true -Dplay.evolutions.db.default.autoApplyDowns=true