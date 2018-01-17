#!/usr/bin/env bash

#Gonna just define this up here, why not eh?
_now=$(date +"%m_%d_%Y")

#Friendly banter, section 1
echo Hi, what\'s your name?
read varname
sleep 1
echo Alright $varname, been a while.
sleep 1
echo So what box we configuring?
read device
sleep 1
echo Ahhh, the old $device eh? Classic.
sleep 1
echo Now I am gonna need a quick description from you for this piece of work. Something like *customer - circuit ID* as an example...
sleep 1
read job

#Nice, got a job ref. Gonna define a filename here then.
_file="$job-$_now"

#Carry on the banter
sleep 1
echo Wow, you\'re good! Now enter your commands here with a comma between each one, and I\'ll sort you right out.
read config
#sets temp IFS to comma
IFS=',' read -a config <<< "$config"


#Function to accept 4 commands delimited by commas, and store them as strings
for ((i=0, j=1; i< ${#config[@]}; i++, j++)); do
   declare "command$j"="${config[$i]}"
done

sleep 1
echo So give this a once over please...
sleep 2
echo "Command 1: ${config[0]}"
echo "Command 2: ${config[1]}"
echo "Command 3: ${config[2]}"
echo "Command 4: ${config[3]}"
sleep 1
command1="${config[0]}"
command2="${config[1]}"
command3="${config[2]}"
command4="${config[3]}"

while true
do

  read -p "This correct bud? (Y/N)" answer

#Function to output commands for verification
  case $answer in
   [nN]* )
                echo "K, I\', gone..."
                exit
                ;;
   [yY]* )
                echo Cool! So I\'m gonna give you a command. Just paste it right here into your pal NAB and I\'ll get you your output.
                sleep 3
                echo " "
                echo 'clogin -c "'$command1';'$command2';'$command3';'$command4'" '$device' 2>&1 > '${_file}.txt'' && cat ${_file}.txt | sendmail networksinbox@jtglobal.com
                echo " "
                sleep 5
                read -p "All good now, pal? (Y/N)" finalanswer
#Sub case for exit confirmation
                        case $finalanswer in
                                 [yY]* )
                                                echo "Sweet! I'm off, catch ya later."
                                                sleep 5
                                                break
                                                ;;

                                 [nN]* )
                                                sleep 3
                                                echo "Damn, I haven't been coded for this situtation. Re-run the Wizard pls."
                                                exit
                                                ;;

                                * )
                                                echo "Dude, just enter Y or N, please."
                                                ;;
                                esac
                                ;;
        * )
                echo "Dude, just enter Y or N, please."
                ;;
esac

done
