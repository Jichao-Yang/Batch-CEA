clear; clc;

% ================xls to inp================

% read data from user created xls
[~, ~, data] = xlsread('CEAdata.xls', 'sheet1');
data = data(2:end, 2:end);
[case_num, ~] = size(data);

% convert data to .inp files
f = waitbar(0,'Generating Input Files...');
for i = 1:case_num
    case_inp = generate_input(data(i, :));
    fid = fopen(sprintf('%s%d.%s', 'case_', i, 'inp'), 'wt');
    fprintf(fid, '%s', case_inp);
    fclose(fid);
    waitbar(i/case_num,f,'Generating Input Files...');
end
close(f); fclose('all');

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
f = waitbar(0,'Running CEA Backend...');
for i = 1:inp_num
    dos(sprintf('%s%s%s', 'echo ', FileNames{i}, ' | FCEA2 > nul'));
    waitbar(i/inp_num,f,'Running CEA Backend...');
end
close(f); fclose('all');

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
header_variable = {'Big_gamma','C_star_theoretical','C_F_0','ISP_theoretical'};
xlswrite('CEAdata.xls', header, 'Sheet2', 'A1');
xlswrite('CEAdata.xls', header_variable, 'Sheet2', 'I1');
f = waitbar(0,'Writing data...');
for i = 1:plt_num
    xlswrite('CEAdata.xls', strsplit(plt_val{i}{2}), 'Sheet2', sprintf('%s%d', 'B', i+1));
    [a,b,c,d] = myequationo(i);
    xlswrite('CEAdata.xls', [a,b,c,d], 'Sheet2', sprintf('%s%d', char(65+length(header)), i+1));
    waitbar(i/plt_num,f,'Writing data...');
end
close(f); fclose('all');

% ================delete generated files================
promptMessage = sprintf('Do you wish to delete all generated files?');
titleBarCaption = 'Select Action';
button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No', 'Yes');
if strcmpi(button, 'Yes')
    fclose('all');
    delete *.plt; delete *.out; delete *.inp;
end
    
% ===============open xls when finished=================
winopen('CEAdata.xls');
