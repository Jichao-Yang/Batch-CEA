clear; clc;
densityAL = 2.700; %str2num(answer{1});
dataset = xlsread('CEAdata.xls','Sheet3','A1:I101');
datasetphi = xlsread('CEAdata.xls','Sheet2','A1:H101');
choice = menu('Select a graph:','Tc','Isp','RhoIsp');
% answer1 = inputdlg('Enter Fuel Composition Percentage for Test 1:',...
%     'Sample', [1 50]);
% percent = str2num(answer1{1});
% 
% answer1 = inputdlg('Enter Fuel Composition Percentage for Test 2:',...
%     'Sample', [1 50]);
% percent1 = str2num(answer1{1});
% 
% answer1 = inputdlg('Enter Fuel Composition Percentage for Test 3:',...
%     'Sample', [1 50]);
% percent2 = str2num(answer1{1});
%answer2 = inputdlg('Enter Fuel Density 2:',...
%'Sample', [1 50]);

percent = 0;
percent1 = 10;
percent2 = 20;

densityWAX = 0.834; %str2num(answer2{1});
x = datasetphi(:,7); % Untested

rho = dataset(:,4);
rho1 = dataset(:,5);
rho2 = dataset(:,6);

density = 1/(((percent)/100)/(densityAL)+((100 - percent)/100)/(densityWAX));
density1 = 1/(((percent1)/100)/(densityAL)+((100 - percent1)/100)/(densityWAX));
density2 = 1/(((percent2)/100)/(densityAL)+((100 - percent2)/100)/(densityWAX));

rhof = 1/((((rho)/100)/density)+((1-(rho/100))/1.141));
rhof1 = 1/((((rho1)/100)/density1)+((1-(rho1/100))/1.141));
rhof2 = 1/((((rho2)/100)/density2)+((1-(rho2/100))/1.141));

%====================FirstGraph====================%
if choice == 1
    t = dataset(:,1); % First trial temperature
    t1 = dataset(:,2); % Second trial temperature
    t2 = dataset(:,3); % Third trial temperature

    ax1 = subplot(1,1,1); % Top subplot
    p = plot(ax1,x,t);
    title(ax1,'TC vs \phi')
    ylabel(ax1,'TC')
    xlabel(ax1,'\phi')

    hold on
    p1 = plot(ax1,x,t1);

    hold on
    p2 = plot(ax1,x,t2);
    legend(sprintf('%d%s',percent','% AL'),sprintf('%d%s',percent1,'% AL'),sprintf('%d%s',percent2,'% AL'))
    hold off

    p(1).LineWidth = 2;
    p1(1).LineWidth = 2;
    p2(1).LineWidth = 2;
end
%====================SecondGraph====================%
if choice == 2
    isp = dataset(:,7); % First trial temperature
    isp1 = dataset(:,8); % Second trial temperature
    isp2 = dataset(:,9); % Third trial temperature

    ax2 = subplot(1,1,1); % Top subplot
    l = plot(ax2,x,isp);
    title(ax2,'Isp vs \phi')
    ylabel(ax2,'Isp [s]')
    xlabel(ax2,'\phi')

    hold on
    l1 = plot(ax2,x,isp1);

    hold on
    l2 = plot(ax2,x,isp2);
    legend(sprintf('%d%s',percent','% AL'),sprintf('%d%s',percent1,'% AL'),sprintf('%d%s',percent2,'% AL'))
    hold off

    l(1).LineWidth = 2;
    l1(1).LineWidth = 2;
    l2(1).LineWidth = 2;
end
%====================ThirdGraph====================%
if choice == 3
    y3 = rhof(100) .* dataset(:,7); % Untested
    y4 = rhof1(100) .* dataset(:,8); % Untested
    y5 = rhof2(100) .* dataset(:,9); % Untested

    ax3 = subplot(1,1,1); % bottom subplot
    m = plot(ax3,x,y3);
    title(ax3,'\rho Isp vs \phi')
    ylabel(ax3,'\rho Isp [g s/cm^3]')
    xlabel(ax3,'\phi')

    hold on
    m1 = plot(ax3,x,y4);

    hold on
    m2 = plot(ax3,x,y5);
    legend(sprintf('%d%s',percent','% AL'),sprintf('%d%s',percent1,'% AL'),sprintf('%d%s',percent2,'% AL'))

    m(1).LineWidth = 2;
    m1(1).LineWidth = 2;
    m2(1).LineWidth = 2;

    hold off
end



