########################################
####     OBS Bungie Data v3.6       ####
####   Call Bungie API get grim     ####
#### 	  the100:  /u/L0r3          ####
####      Reddit:  /u/L0r3_Titan    ####
####      Twitter: @L0r3_Titan      ####
########################################


#### VARIABLES TO SET ####
player='L0r3'
streamData='/Users/L0R3/stream/obs_text/chat_log.txt'


### SET XBOX OR PSN TO MATCH 'PLAYER' ACCOUNT ABOVE ###
# Xbox=1 Psn=2
XBOXorPSN='1'


#### FILE WITH YOUR BUNGIE API KEY ####
# put your bungie api key in that file parallel with this script
# contents of file should look like: authKeyBungie='X-API-Key: abcdefg1234567abcdefg1234567abcd'
currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$currentDir"'/apiKeys.sh'


### FUCTION TO SEND GAMERTAG TO BUNGIE TO GET MEMBER ID ###
funcMemID ()
{
getUserData=`curl -s -X GET \
-H "Content-Type: application/json" -H "Accept: application/xml" -H "$authKeyBungie" \
"https://www.bungie.net/Platform/Destiny/SearchDestinyPlayer/$XBOXorPSN/$player/"`
niceMemID=`echo "$getUserData" | python -mjson.tool`
memID=`echo "$niceMemID" | grep -o 'membershipId.*' | cut -c 17- | rev | cut -c 3- | rev`
#echo "$memID"
}


### GET CHARCTER INFO ###
funcGetCharInfo ()
{
charInfo=`curl -s -X GET \
-H "Content-Type: application/json" -H "Accept: application/xml" -H "$authKeyBungie" \
"https://www.bungie.net/Platform/Destiny/$XBOXorPSN/Account/$memID/"`
niceCharInfo=`echo "$charInfo" | python -mjson.tool`
#echo "$niceCharInfo"
}


### EXTRACT CHAR ID NUMBERS ###
funcExtractId ()
{
charIdAll=`echo "$niceCharInfo" | grep -o 'characterId.*'`
charIdA=`echo "$charIdAll" | sed -n 1p | cut -c 16- | rev | cut -c 3- | rev`
charIdB=`echo "$charIdAll" | sed -n 2p | cut -c 16- | rev | cut -c 3- | rev`
charIdC=`echo "$charIdAll" | sed -n 3p | cut -c 16- | rev | cut -c 3- | rev`
#echo "$charIdA $charIdB $charIdC"
}


### EXTRACT CLASS ID NUMBERS ###
funcExtractClass ()
{
charClassAll=`echo "$niceCharInfo" | grep -o 'classHash.*'`
charClassIdA=`echo "$charClassAll" | sed -n 1p | cut -c 13- | rev | cut -c 2- | rev`
charClassIdB=`echo "$charClassAll" | sed -n 2p | cut -c 13- | rev | cut -c 2- | rev`
charClassIdC=`echo "$charClassAll" | sed -n 3p | cut -c 13- | rev | cut -c 2- | rev`
#echo "$charClassIdA $charClassIdB $charClassIdC"
}


### IDENTIFY CLASS TYPE ###
funcClassType ()
{
if [ $charClassIdA == '3655393761' ]; then
	charTypeA='Titan'
elif [ $charClassIdA == '671679327' ]; then
	charTypeA='Hunter'
elif [ $charClassIdA == '2271682572' ]; then
	charTypeA='Warlock'
fi
if [ $charClassIdB == '3655393761' ]; then
	charTypeB='Titan'
elif [ $charClassIdB == '671679327' ]; then
	charTypeB='Hunter'
elif [ $charClassIdB == '2271682572' ]; then
	charTypeB='Warlock'
fi
if [ $charClassIdC == '3655393761' ]; then
	charTypeC='Titan'
elif [ $charClassIdC == '671679327' ]; then
	charTypeC='Hunter'
elif [ $charClassIdC == '2271682572' ]; then
	charTypeC='Warlock'
fi
#echo "$charTypeA $charTypeB $charTypeC"
}


### GET TITAN GRIM CARD ###
funcTitanCard ()
{
grimCardTitan=`curl -s -X GET \
-H "Content-Type: application/json" -H "Accept: application/xml" -H "$authKeyBungie" \
"https://www.bungie.net/Platform/Destiny/Vanguard/Grimoire/1/$memID/?single=101010"`
niceGrimTitan=`echo "$grimCardTitan" | python -mjson.tool`
#echo "niceGrimTitan: $niceGrimTitan"
}


### GET TITAN KILLS ###
funcTitanKills ()
{
killsTitanMinion=`echo "$niceGrimTitan" | grep -o 'statNumber": 1' -A1 | tail -n 1 | sed  s/\ //g | cut -c 9- | rev | cut -c 3- | rev`
killsTitanCrucible=`echo "$niceGrimTitan" | grep -o 'statNumber": 2' -A1 | tail -n 1 | sed  s/\ //g | cut -c 9- | rev | cut -c 3- | rev`
#echo "killsTitanMinion:$killsTitanMinion killsTitanCrucible:$killsTitanCrucible"
}


### GET HUNTER GRIM CARD ###
funcHunterCard ()
{
grimCardHunter=`curl -s -X GET \
-H "Content-Type: application/json" -H "Accept: application/xml" -H "$authKeyBungie" \
"https://www.bungie.net/Platform/Destiny/Vanguard/Grimoire/1/$memID/?single=101020"`
niceGrimHunter=`echo "$grimCardHunter" | python -mjson.tool`
#echo "niceGrimHunter: $niceGrimHunter"
}


### GET HUNTER KILLS ###
funcHunterKills ()
{
killsHunterMinion=`echo "$niceGrimHunter" | grep -o 'statNumber": 1' -A1 | tail -n 1 | sed  s/\ //g | cut -c 9- | rev | cut -c 3- | rev`
killsHunterCrucible=`echo "$niceGrimHunter" | grep -o 'statNumber": 2' -A1 | tail -n 1 | sed  s/\ //g | cut -c 9- | rev | cut -c 3- | rev`
#echo "killsHunterMinion:$killsHunterMinion killsHunterCrucible:$killsHunterCrucible"
}


### GET WARLOCK GRIM CARD ###
funcWarlockCard ()
{
grimCardWarlock=`curl -s -X GET \
-H "Content-Type: application/json" -H "Accept: application/xml" -H "$authKeyBungie" \
"https://www.bungie.net/Platform/Destiny/Vanguard/Grimoire/1/$memID/?single=101030"`
niceGrimWarlock=`echo "$grimCardWarlock" | python -mjson.tool`
#echo "niceGrimWarlock: $niceGrimWarlock"
}


### GET WARLOCK KILLS ###
funcWarlockKills ()
{
killsWarlockMinion=`echo "$niceGrimWarlock" | grep -o 'statNumber": 1' -A1 | tail -n 1 | sed  s/\ //g | cut -c 9- | rev | cut -c 3- | rev`
killsWarlockCrucible=`echo "$niceGrimWarlock" | grep -o 'statNumber": 2' -A1 | tail -n 1 | sed  s/\ //g | cut -c 9- | rev | cut -c 3- | rev`
#echo "killsWarlockMinion:$killsWarlockMinion killsWarlockCrucible:$killsWarlockCrucible"
}


funcMemID
funcGetCharInfo
funcExtractId
funcExtractClass
#funcClassType
funcTitanCard
funcTitanKills
funcHunterCard
funcHunterKills
funcWarlockCard
funcWarlockKills


let allKillsMinion=$killsTitanMinion+killsHunterMinion+killsWarlockMinion
let allkillsCrucible=$killsTitanCrucible+killsHunterCrucible+killsWarlockCrucible
echo; echo
echo "allKillsMinion: $allKillsMinion"
echo "allkillsCrucible: $allkillsCrucible"


########################################################################################


#### FUNCTION TO TIME FOR A PLAYER FROM wastedondestiny.com API ####
funcGetTimeData ()
{
getWastedData=`curl -s -X GET "http://www.wastedondestiny.com/api/?console=$XBOXorPSN&user=$player"`
niceWastedData=`echo "$getWastedData" | python -mjson.tool`
timeSeconds=`echo "$niceWastedData" | grep -o 'totalTimePlayed":.*' | cut -c 19- | rev | cut -c 2- | rev`
sixty='60'
timeMinutes=$((timeSeconds / sixty))
timeHours=$((timeMinutes / sixty))
echo "timeHours: $timeHours"
}

funcGetTimeData


##########################################################################################

### GET RAID BOSS KILLS GRIM CARD ###
funcGetGrimBossKills ()
{
grimCardBossKills=`curl -s -X GET \
-H "Content-Type: application/json" -H "Accept: application/xml" -H "$authKeyBungie" \
"https://www.bungie.net/Platform/Destiny/Vanguard/Grimoire/1/$memID/?single=603010"`
niceCardBossKills=`echo "$grimCardBossKills" | python -mjson.tool`
#echo "niceCardBossKills: $niceCardBossKills"
}


### GET KILLS FROM GROM CARD###
funcBossKills ()
{
bossKills=`echo "$niceCardBossKills" | grep -o 'statNumber": 1' -A1 | tail -n 1 | sed  s/\ //g | cut -c 9- | rev | cut -c 3- | rev`
echo "bossKills: $bossKills"
}


funcGetGrimBossKills
funcBossKills


##########################################################################################


writeData="Raid Completions: $bossKills\nHours Played: $timeHours\nMinion Kills: $allKillsMinion\n\n"
echo -e "$writeData" > "$streamData"
exit


##########################################################################################

