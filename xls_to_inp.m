clear; clc;

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