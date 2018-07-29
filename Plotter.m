clear; clc;
    %answer = inputdlg('Enter Fuel Density 1:',...
                % 'Sample', [1 50]);
             density1 = 2700; %str2num(answer{1});
             
    answer1 = inputdlg('Enter Fuel Composition Percentage:',...
                 'Sample', [1 50]);
             percent = str2num(answer1{1});
             
    %answer2 = inputdlg('Enter Fuel Density 2:',...
                 %'Sample', [1 50]);
             density2 = 834; %str2num(answer2{1});
            
density = 1/(((percent)/100)/(density1)+((100 - percent)/100)/(density2));
             
dataset = xlsread('CEAdata.xls','Sheet2','B1:L99');

x = dataset(:,7); % Untested
y = dataset(:,2); % Untested

ax1 = subplot(3,1,1); % top subplot
plot(ax1,x,y)
title(ax1,'Tc vs \phi')
ylabel(ax1,'TC')
xlabel(ax1,'\phi')


y2 = dataset(:,11); % Untested

ax2 = subplot(3,1,2); % bottom subplot
plot(ax2,x,y2)
title(ax2,'Isp vs \phi')
ylabel(ax2,'Isp')
xlabel(ax2,'\phi')


y3 = density * dataset(:,11); % Untested

ax3 = subplot(3,1,3); % bottom subplot
p = plot(ax3,x,y3);
title(ax3,'\rho Isp vs \phi')
ylabel(ax3,'\rho Isp')
xlabel(ax3,'\phi')
%p(1).Marker = '*';
