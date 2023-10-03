Count_Master=1
while [ $Count_Master -lt 10 ] ; do
env DISPLAY=:0 flatpak run org.octave.Octave /home/bencsik/Desktop/Bencsik_code/Hive_Knocks/generate_sleep_time.m
input="/home/bencsik/Desktop/Bencsik_code/Hive_Knocks/waiting.txt"

while IFS= read -r line
do

OUT=$line

#echo "$OUT"
sleep $OUT

amixer -c 0 sset 'Master' 100%
sleep 1
date >> '/home/bencsik/Desktop/Bencsik_code/Hive_Knocks/actual_dates.txt'
aplay -D plughw:0,0 /home/bencsik/Desktop/Bencsik_code/Hive_Knocks/sine.wav

done < "$input"

done


