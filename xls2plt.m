clear; clc;
% =========xls to inp===========

[~,~,data] = xlsread('CEAdata.xls', 'sheet1');
data = data(2:end,2:end);
[case_num,~] = size(data);

for i = 1:case_num
    case_data = data(i,:);
    case_inp = generate_input(case_data);
    fid = fopen(sprintf('%s%d.%s', 'case_',i, 'inp'),'wt');
    fprintf(fid, '%s', case_inp);
    fclose(fid);
end

% =========inp to plt===========
promptMessage = sprintf('Do you wish to run all .inp files?');
titleBarCaption = 'Select Action';
numberOfUsers = 1;
buttonSelections = zeros(1, numberOfUsers); % Preallocate.
for userNumber = 1 : numberOfUsers
	button = questdlg(promptMessage, titleBarCaption, 'Manually Select', 'Run All Files', 'Run All Files');
	if strcmpi(button, 'Manually Select')
        autorun = false;
    else
        autorun = true;
	end
end

if autorun == false
    [FileNames, PathNames]=uigetfile('*.inp', 'Chose files to load:','MultiSelect','on'); %select multiple files
    if ischar(FileNames)
        N = 1 ;
    else
        N = length(FileNames) ;
    end
    for file = 1:N                         %for loop to cycle through all files
        if N ==1
            fullpath = [PathNames,FileNames] ;
        else
            fullpath = [PathNames,FileNames{file}];    %define the path to file
        end
    end

    for i = 1:length(FileNames)
        name = FileNames{i};
        name = name(1:end-4);
        dos(sprintf('%s%s%s', 'echo ', name, ' | FCEA2 > nul'));
    end
else
    for i = 1:case_num
        dos(sprintf('%s%d%s', 'echo case_', i, ' | FCEA2 > nul'));
    end
end