clear all;
clc
[FileNames, PathNames] = uigetfile('*.plt', 'Chose files to load:', 'MultiSelect', 'on'); %select multiple files
if ischar(FileNames)
    N = 1;
else
    N = length(FileNames);
end
for file = 1:N %for loop to cycle through all files
    if N == 1
        fullpath = [PathNames, FileNames];
    else
        fullpath = [PathNames, FileNames{file}]; %define the path to file
    end
    formatSpec = '%s%s%s%[^\n\r]'; %for textscan
    delimiter = '\t';
    startRow = 3; %start of data
    endRow = 4; %end of data
    %  fileID = fopen(fullpath,'r','UTF-8');   %open the file
    fileID = fopen(fullpath, 'r'); %open the file
    line_read = textscan(fileID, formatSpec, 'delimiter', delimiter); %read the file as strings
    % T = cellstr(T);
    result = strsplit(line_read{1}{2});

    %# output file name
    fName = fullfile(pwd, 'CEAdata.xls');

    %# create Excel COM Server
    Excel = actxserver('Excel.Application');
    Excel.Visible = false;
    data = ones(10, 4); %Sample 2-dimensional data
    %col_header=result;     %Row cell array (for column labels)

    %row_header(1:10,1)={'Trial'};     %Column cell array (for row labels)

    xlswrite('CEAdata.xls', result, 'Sheet2', sprintf('%s%d', 'B', file)); %Write column header
end
%# close Excel
Excel.Quit();
winopen('CEAdata.xls')

