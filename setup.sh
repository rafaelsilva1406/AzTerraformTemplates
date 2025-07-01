##
# Author: Rafael Silva
#
# Description: Only use if havent signed in within cmd, future extend flexibility for more providers
##

#username
usr=$1
#password
pwd=$2
#tenant
tnt=$3


#service principal login
az login --service-principal --username $usr --password $pwd --tenant $tnt

echo $tnt