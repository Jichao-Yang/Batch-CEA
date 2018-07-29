clear; clc;

% ================xls to inp================

% read data from user created xls
[~, ~, data] = xlsread('CEAdata.xls', 'sheet1');
data = data(2:end, 2:end);
[case_num, ~] = size(data);

% convert data to .inp files
for i = 1:case_num
    case_inp = generate_input(data(i, :));
    fid = fopen(sprintf('%s%d.%s', 'case_', i, 'inp'), 'wt');
    fprintf(fid, '%s', case_inp);
    fclose(fid);
end

% ================inp to plt================

% prompt message between manual selection and autorun
promptMessage = sprintf('Do you wish to run all .inp files?');
titleBarCaption = 'Select Action';
button = questdlg(promptMessage, titleBarCaption, 'Manually Select', 'Run All Files', 'Run All Files');
if strcmpi(button, 'Manually Select')
    autoruninp = false;
else
    autoruninp = true;
end

% generate list of .inp file names to be processed
if autoruninp == false
    % select multiple files through dialogue box
    [FileNames,~] = uigetfile('*.inp', 'Chose files to load:', 'MultiSelect', 'on');
    if ischar(FileNames)
        FileNames = {FileNames};
    end
    inp_num = length(FileNames);
    for i = 1:inp_num
        name = FileNames{i};
        name = name(1:end-4);
        FileNames{i} = name;
    end
else
    inp_num = case_num;
    FileNames = cell([1,inp_num]);
    for i = 1:inp_num
        FileNames{i} = sprintf('%s%d', 'case_', i);
    end
end

% run CEA to process .inp files selected
for i = 1:inp_num
    dos(sprintf('%s%s%s', 'echo ', FileNames{i}, ' | FCEA2 > nul'));
end

% ================plt to xls================

% prompt message between manual selection and autorun
promptMessage = sprintf('Do you wish to run all .plt files?');
titleBarCaption = 'Select Action';
button = questdlg(promptMessage, titleBarCaption, 'Manually Select', 'Run All Files', 'Run All Files');
if strcmpi(button, 'Manually Select')
    autorunplt = false;
else
    autorunplt = true;
end

% read all .plt files selected by user
if autorunplt == false
    [FileNames,~] = uigetfile('*.plt', 'Chose files to load:', 'MultiSelect', 'on');
    if ischar(FileNames)
        FileNames = {FileNames};
    end
    plt_num = length(FileNames);
    plt_val = cell([i,1]);
    for i = 1:plt_num
        full_path = ['./', FileNames{i}];
        % read .plt file as string
        line_read = textscan(fopen(full_path, 'r'), '%s%s%s%[^\n\r]', 'delimiter', '\t');
        plt_val{i} = line_read{1};
    end
else
    plt_num = case_num;
    plt_val = cell([i,1]);
    for i = 1:plt_num
        full_path = sprintf('%s%s%d%s', '.\', 'case_', i, '.plt');
        % read .plt file as string
        line_read = textscan(fopen(full_path, 'r'), '%s%s%s%[^\n\r]', 'delimiter', '\t'); % read the file as strings
        plt_val{i} = line_read{1};
    end
end

% write .plt data to xls
header = strsplit(plt_val{1}{1});
xlswrite('CEAdata.xls', header, 'Sheet2', 'A1');

for i = 1:plt_num
    plt_val{i} = strsplit(plt_val{i}{2});
    xlswrite('CEAdata.xls', plt_val{i}, 'Sheet2', sprintf('%s%d', 'B', i+1));
    xlswrite('CEAdata.xls', sprintf('%d', i), 'Sheet2', sprintf('%s%d', 'A', i+1));
end

% calculate necessary variables
xlswrite('CEAdata.xls', {'Big_gamma','C_star_theoretical','C_F_0','ISP_theoretical'}, 'Sheet2', 'I1');
for i = 1:case_num
    [gamb,cth,cf,ispth] = myequationo(i);
    xlswrite('CEAdata.xls', [gamb,cth,cf,ispth], 'Sheet2', sprintf('%s%d', 'I', i+1));
end

% open xls when finished
winopen('CEAdata.xls');
