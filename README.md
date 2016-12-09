# OBS Stream Data #
the100.io: https://www.the100.io/u/L0r3<br>
Twitter: @L0r3_Titan<br>
XB1 GT: L0r3<br>

# WHAT IS THIS STUFF 'N JUNK? #
A BASH script that gathers data from the Bungie API and timewastedondestiny.com API
Writes the data to a plain text file so that OBS streaming software can read it

# HOW DO I USE IT #

Edit the items at top of the script:
- User name of console, Xbox gamertag or PSN name
- Set the console type for that user, 1 Xbox, 2 PSN
- Set the path to the file the script will write data to

Edit the 'apiKeys.sh' file with your Bungie API key

Add a new 'source' --> 'text' to OBS
In the new text source, choose read from file and point it to the path you configured in the script

Set cron/launchd/etc to run the script automatically every few minutes

# NOTE #
This has been tested and works on Mac OS and SUSE Linux
This has been tested for Xbox GT, but not PSN 


