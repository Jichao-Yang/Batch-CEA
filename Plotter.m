clear; clc;
%answer = inputdlg('Enter Fuel Density 1:',...
% 'Sample', [1 50]);
density1 = 2700; %str2num(answer{1});
dataset = xlsread('CEAdata.xls','Sheet3','A1:I10');

answer1 = inputdlg('Enter Fuel Composition Percentage for Test 1:',...
    'Sample', [1 50]);
percent = str2num(answer1{1});

answer1 = inputdlg('Enter Fuel Composition Percentage for Test 2:',...
    'Sample', [1 50]);
percent1 = str2num(answer1{1});

answer1 = inputdlg('Enter Fuel Composition Percentage for Test 3:',...
    'Sample', [1 50]);
percent2 = str2num(answer1{1});
%answer2 = inputdlg('Enter Fuel Density 2:',...
%'Sample', [1 50]);
density2 = 834; %str2num(answer2{1});

rho = dataset(:,4);
rho1 = dataset(:,5);
rho2 = dataset(:,6);

density = 1/(((percent)/100)/(density1)+((100 - percent)/100)/(density2));
density1 = 1/(((percent1)/100)/(density1)+((100 - percent1)/100)/(density2));
density2 = 1/(((percent2)/100)/(density1)+((100 - percent2)/100)/(density2));

rhof = 1/((((rho)/100)/density)+(((1-rho)/100)/1.141));
rhof1 = 1/((((rho1)/100)/density1)+(((1-rho1)/100)/1.141));
rhof3 = 1/((((rho2)/100)/density2)+(((1-rho2)/100)/1.141));

%====================FirstGraph====================%
x = dataset(:,7); % Untested
t = dataset(:,1); % First trial temperature
t1 = dataset(:,2); % Second trial temperature
t2 = dataset(:,3); % Third trial temperature

ax1 = subplot(3,1,1); % Top subplot
p = plot(ax1,x,t);
title(ax1,'TC vs \phi')
ylabel(ax1,'TC')
xlabel(ax1,'\phi')

hold on
plot(ax1,x,t1)

hold on
plot(ax1,x,t2)
legend(sprintf('%d%s',percent2','% AL'),sprintf('%d%s',percent1,'% AL'),sprintf('%d%s',percent,'% AL'))
hold off
p(1).LineWidth = 2;
%====================SecondGraph====================%

isp = dataset(:,7); % First trial temperature
isp1 = dataset(:,8); % Second trial temperature
isp2 = dataset(:,9); % Third trial temperature

ax2 = subplot(3,1,2); % Top subplot
p = plot(ax2,x,isp);
title(ax2,'Isp vs \phi')
ylabel(ax2,'Isp')
xlabel(ax2,'\phi')

hold on
plot(ax2,x,isp1)

hold on
plot(ax2,x,isp2)
legend(sprintf('%d%s',percent2','% AL'),sprintf('%d%s',percent1,'% AL'),sprintf('%d%s',percent,'% AL'))
hold off
p(1).LineWidth = 2;

%====================ThirdGraph====================%

y3 = rho .* dataset(:,7); % Untested
y4 = rho1 .* dataset(:,8); % Untested
y5 = rho2 .* dataset(:,9); % Untested

ax3 = subplot(3,1,3); % bottom subplot
p = plot(ax3,x,y3);
title(ax3,'\rho Isp vs \phi')
ylabel(ax3,'\rho Isp')
xlabel(ax3,'\phi')

hold on
plot(ax3,x,y4)

hold on
plot(ax3,x,y5)
legend(sprintf('%d%s',percent2','% AL'),sprintf('%d%s',percent1,'% AL'),sprintf('%d%s',percent,'% AL'))

hold off

p(1).LineWidth = 2;
