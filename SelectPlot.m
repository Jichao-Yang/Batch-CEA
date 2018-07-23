clear all ;
clc
[FileNames, PathNames]=uigetfile('*.plt', 'Chose files to load:','MultiSelect','on'); %select multiple files
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