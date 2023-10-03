clear
% specify the number of hive knocks to be delivered:
Knocks_No = 4;
% Generate three random times in the day where these will be generated:
times_in_the_day = sort(60*60*10*rand(1,Knocks_No),'ascend');
%times_in_the_day = sort(20*rand(1,Knocks_No),'ascend');
% Generate the time duration of the computer sleep required:
Sleep_times(1) = times_in_the_day(1);
for uu = 2:Knocks_No
Sleep_times(uu) = (times_in_the_day(uu)-times_in_the_day(uu-1));
end
%Sleep_times
%cumsum(Sleep_times)
csvwrite('/home/bencsik/Desktop/Bencsik_code/Hive_Knocks/waiting.txt',Sleep_times(1)')
