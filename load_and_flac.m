
close all
clear

pkg load signal 

graphics_toolkit gnuplot
path(path,'/home/martin/Desktop/Bencsik_code')
% upload the series of timings:
S_R = 11025;

[reference_wave SRref] = audioread('/home/martin/Desktop/Bencsik_code/Hive_Knocks/sine.wav');
reference_wave = reference_wave(1:4:end);
fid = fopen('/home/martin/Desktop/Bencsik_code/Hive_Knocks/actual_dates.txt');
tline = fgetl(fid);
uu = 1;
while ischar(tline)
  stimulus_epoch_time(uu) = epoch_from_bash(tline); 
  tline = fgetl(fid);
  uu = uu + 1;
end
fclose(fid);

% check for the data that has already been processed:
% Give the location where the folder with flac files are:
location_name = '/home/martin/Desktop/Bencsik_code/Hive_Knocks/flac_data/';
% find the directories that are in that location:
files_info = dir([location_name,'*.flac']);
if length(files_info) > 0
  last_epoch_time = files_info(end).name;
  last_epoch_time = str2num(last_epoch_time(1:end-4));
else
  last_epoch_time = 0;
end


% Give the location where the folder with flac files are:
location_name = '/media/martin/35D3-D8C5/HPP_bees/';
% find the directories that are in that location:
directories = dir([location_name]);
directories = directories(3:end);
dirFlags = [directories.isdir];
directories = directories(dirFlags);

for uu = 1:size(directories,1)
  dir_no(uu) = str2num(directories(uu).name);
end
[aa bb] = sort(dir_no,'ascend');
dir_no = dir_no(bb);
data_matrix_1 = [];
data_matrix_2 = [];
time_data = [];
signal_before = [];
signal_after = [];

##colormap(jet(256))

for Folder_No = dir_no
  
  % Find out how many files there are and order them chronologically:
  flac_files = dir([location_name,num2str(Folder_No),'/*.flac']);
  if size(flac_files,1) > 0
    
    for uu = 1:length(flac_files)
      file_saved_at_epoch(uu) = get_epoch_from_file(flac_files(uu).date);
    end
    [a chronos_correct] = sort(file_saved_at_epoch,'ascend');
    
    for uu = chronos_correct
      if (file_saved_at_epoch(uu) > stimulus_epoch_time(1)) 
        flag = 1;
        while flag
          LL = round((60*60 - (file_saved_at_epoch(uu) + 0.5 - stimulus_epoch_time(1)))*S_R);                
          UL = LL + 4*S_R;
          if (LL > 0) && (stimulus_epoch_time(1) > last_epoch_time)
            
            if UL <= 60*60*S_R
              [Acc S_R] = audioread([location_name,num2str(Folder_No),'/',flac_files(uu).name],[LL UL]);
            else
              [temp1 S_R] = audioread([location_name,num2str(Folder_No),'/',flac_files(uu).name],[LL 60*60*S_R]);
              name_f = flac_files(uu).name;
              next_file = [num2str((str2num(name_f(1:end-5))+1)) '.flac'];
              [temp2 S_R] = audioread([location_name,num2str(Folder_No),'/',next_file],[1 (size(LL:UL,2) - size(temp1,1))]);
              for ch=1:8
                Acc(:,ch) = [temp1(:,ch);temp2(:,ch)];
              end
            end
            
            [R lag] = xcorr(reference_wave,flipud(Acc(:,1)));
            [val shift] = max(R);     
            LL = LL + shift - S_R - 7000;
            UL = LL + 4*S_R;
            
            if UL <= 60*60*S_R
              [Acc S_R] = audioread([location_name,num2str(Folder_No),'/',flac_files(uu).name],[LL UL]);
            else
              [temp1 S_R] = audioread([location_name,num2str(Folder_No),'/',flac_files(uu).name],[LL 60*60*S_R]);
              name_f = flac_files(uu).name;
              next_file = [num2str((str2num(name_f(1:end-5))+1)) '.flac'];
              [temp2 S_R] = audioread([location_name,num2str(Folder_No),'/',next_file],[1 (size(LL:UL,2) - size(temp1,1))]);
              for ch=1:8
                Acc(:,ch) = [temp1(:,ch);temp2(:,ch)];
              end
            end
            
            time_data(end+1) = stimulus_epoch_time(1);
            disp(ctime(stimulus_epoch_time(1)))
            audiowrite(['/home/martin/Desktop/Bencsik_code/Hive_Knocks/flac_data/',num2str(stimulus_epoch_time(1)),'.flac'],Acc,S_R)
          end
          if length(stimulus_epoch_time) > 1
            stimulus_epoch_time = stimulus_epoch_time(2:end);
          else
            exit
          end
          if file_saved_at_epoch(uu) < stimulus_epoch_time(1)
            flag = 0;
          end
        end      
        
      end      
      
    end
    
  end
  
  end