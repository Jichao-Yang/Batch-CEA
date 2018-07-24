clear; clc;
% =========xls to inp===========

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

function inp = generate_input(list)
    problem_type = list(1); problem_type = string(problem_type{1});
    pressure_unit = list(2); pressure_unit = string(pressure_unit{1});
    pressure_val = list(3); pressure_val = string(pressure_val{1});
    temp_unit = list(4); temp_unit = string(temp_unit{1});
    temp_val = list(5); temp_val = string(temp_val{1});
    reactant_amount_unit = list(6); reactant_amount_unit = string(reactant_amount_unit{1});
    reactant_temp_unit = list(7); reactant_temp_unit = string(reactant_temp_unit{1});
    fuel_name = list(8); fuel_name = string(fuel_name{1});
    fuel_amount = list(9); fuel_amount = string(fuel_amount{1});
    fuel_temp = list(10); fuel_temp = string(fuel_temp{1});
    oxid_name = list(11); oxid_name = string(oxid_name{1});
    oxid_amount = list(12); oxid_amount = string(oxid_amount{1});
    oxid_temp = list(13); oxid_temp = string(oxid_temp{1});
    output = list(14); output = string(output{1});
 
    problem_head = strcat('problem   ', '\n');
    problem_body = strcat({'    '}, problem_type, {'   '}, 'p,', pressure_unit, '=', pressure_val, {',  '}, 't,', temp_unit, '=', temp_val, '\n');
 
    react_head = strcat('react  ', '\n');
    react_body_fuel = strcat({'  '}, 'fuel=', fuel_name, {' '}, reactant_amount_unit, '=', fuel_amount, {'  '}, 't,', reactant_temp_unit, '=', fuel_temp, {'  '}, '\n');
    react_body_oxid = strcat({'  '}, 'oxid=', oxid_name, {' '}, reactant_amount_unit, '=', oxid_amount, {'  '}, 't,', reactant_temp_unit, '=', oxid_temp, {'  '}, '\n');
 
    output_head = strcat('output  ', '\n');
    output_body = strcat('    plot', {' '}, output, ' ', '\n');
 
end_head = strcat('end', '\n');

inp = compose(problem_head + problem_body + react_head + react_body_fuel + react_body_oxid + output_head + output_body + end_head);
end