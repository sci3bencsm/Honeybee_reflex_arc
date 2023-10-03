function y = epoch_from_bash(tline);
  
   time_file.mday = str2num(tline(5:6));
   time_file.hour = str2num(tline(12:13));
   time_file.min = str2num(tline(15:16));
   time_file.sec = str2num(tline(18:19));
   time_file.year = str2num(tline(25:28)) - 1900;   

                if tline(8:10) == 'Jan'
                time_file.mon = 1;
                elseif tline(8:10) == 'Feb'
                time_file.mon = 2;
                elseif tline(8:10) == 'Mar'
                time_file.mon = 3;
                elseif tline(8:10) == 'Apr'
                time_file.mon = 4;
                elseif tline(8:10) == 'May'
                time_file.mon = 5;
                elseif tline(8:10) == 'Jun'
                time_file.mon = 6;
                elseif tline(8:10) == 'Jul'
                time_file.mon = 7;
                elseif tline(8:10) == 'Aug'
                time_file.mon = 8;
                elseif tline(8:10) == 'Sep'
                time_file.mon = 9;
                elseif tline(8:10) == 'Oct'
                time_file.mon = 10;
                elseif tline(8:10) == 'Nov'
                time_file.mon = 11;
                elseif tline(8:10) == 'Dec'
                time_file.mon = 12;
                end                
                time_file.mon = time_file.mon - 1;
                time_file.usec = 0;
                time_file.wday = 0;
                time_file.yday = 0;
                time_file.isdst = 0;
                time_file.zone = 'BST';
y = mktime(time_file);
