clear; clc;

[~, ~, data] = xlsread('CEAdata.xls', 'sheet1');
data = data(2:end, 2:end);
[case_num, ~] = size(data);

for i = 1:case_num
    case_data = data(i, :);
    case_inp = generate_input(case_data);
     fid = fopen(sprintf('%s%d.%s', 'case_', i, 'inp'), 'wt');
     fprintf(fid, '%s', case_inp);
    fclose(fid);
end

% =========inp to plt===========
promptMessage = sprintf('Do you wish to run all .inp files?');
titleBarCaption = 'Select Action';
button = questdlg(promptMessage, titleBarCaption, 'Manually Select', 'Run All Files', 'Run All Files');
if strcmpi(button, 'Manually Select')
    autorunplt = false;
else
    autorunplt = true;
end

if autorunplt == false
    [FileNames, PathNames] = uigetfile('*.inp', 'Chose files to load:', 'MultiSelect', 'on'); % select multiple files
    if ischar(FileNames)
        N = 1;
    else
        N = length(FileNames);
    end
    for file = 1:N % for loop to cycle through all files
        if N == 1
            fullpath = [PathNames, FileNames];
        else
            fullpath = [PathNames, FileNames{file}]; % define the path to file
        end
    end
 
    for i = 1:length(FileNames)
        name = FileNames{i};
        name = name(1:end - 4);
         dos(sprintf('%s%s%s', 'echo ', name, ' | FCEA2 > nul'));
    end
else
    for i = 1:case_num
         dos(sprintf('%s%d%s', 'echo case_', i, ' | FCEA2 > nul'));
    end
end

% =========plt to xls==========
promptMessage = sprintf('Do you wish to run all .plt files?');
titleBarCaption = 'Select Action';
numberOfUsers = 1;
buttonSelections = zeros(1, numberOfUsers); % Preallocate.
for userNumber = 1 : numberOfUsers
    button = questdlg(promptMessage, titleBarCaption, 'Manually Select', 'Run All Files', 'Run All Files');
    if strcmpi(button, 'Manually Select')
        autorunplt = false;
    else
        autorunplt = true;
    end
end

if autorunplt == false
    [FileNames, PathNames] = uigetfile('*.plt', 'Chose files to load:', 'MultiSelect', 'on'); % select multiple files
    if ischar(FileNames)
        N = 1;
    else
        N = length(FileNames);
    end
    for file = 1:N % for loop to cycle through all files
        if N == 1
            fullpath = [PathNames, FileNames];
        else
            fullpath = [PathNames, FileNames{file}]; % define the path to file
        end
        formatSpec = '%s%s%s%[^\n\r]'; % for textscan
        delimiter = '\t';
        startRow = 3; % start of data
        endRow = 4; % end of data
        fileID = fopen(fullpath, 'r'); % open the file
        line_read = textscan(fileID, formatSpec, 'delimiter', delimiter); % read the file as strings
        % T = cellstr(T);
        result = strsplit(line_read{1}{2});
        header = strsplit(line_read{1}{1});
        % # output file name
        fName = fullfile(pwd, 'CEAdata.xls');

        % # create Excel COM Server
        Excel = actxserver('Excel.Application');
        Excel.Visible = false;
        data = ones(10, 4); % Sample 2-dimensional data

        xlswrite('CEAdata.xls', result, 'Sheet2', sprintf('%s%d', 'B', (file + 1))); % Write column header
        xlswrite('CEAdata.xls', file, 'Sheet2', sprintf('%s%d', 'A', (file + 1))); % Write column header
    end
    xlswrite('CEAdata.xls', header, 'Sheet2', 'A1'); % Write column header
    % # close Excel
    Excel.Quit();
else
    for file = 1:case_num
         FileNames{file} = sprintf('%s%d%s', 'case_', file, '.plt');
    end
    PathNames = '.\';
    for file = 1:case_num
        if case_num == 1
            fullpath = [PathNames, FileNames];
        else
            fullpath = [PathNames, FileNames{file}]; % define the path to file
        end
        formatSpec = '%s%s%s%[^\n\r]'; % for textscan
        delimiter = '\t';
        startRow = 3; % start of data
        endRow = 4; % end of data
        fileID = fopen(fullpath, 'r'); % open the file
        line_read = textscan(fileID, formatSpec, 'delimiter', delimiter); % read the file as strings
        % T = cellstr(T);
        result = strsplit(line_read{1}{2});
        header = strsplit(line_read{1}{1});
        % # output file name
        fName = fullfile(pwd, 'CEAdata.xls');

        % # create Excel COM Server
        Excel = actxserver('Excel.Application');
        Excel.Visible = false;
        data = ones(10, 4); % Sample 2-dimensional data

        xlswrite('CEAdata.xls', result, 'Sheet2', sprintf('%s%d', 'B', (file + 1))); % Write column header
        xlswrite('CEAdata.xls', file, 'Sheet2', sprintf('%s%d', 'A', (file + 1))); % Write column header
        xlswrite('CEAdata.xls', header, 'Sheet2', 'A1'); % Write column header
        % # close Excel
        Excel.Quit();
    end
end
winopen('CEAdata.xls');

