clear; clc;

[~,~,data] = xlsread('CEAdata.xls', 'sheet1');
data = data(2:end,2:end);
[case_num,~] = size(data);

%problem_type = "hp";
%pressure_unit = 'bar'; pressure_val = '8.3';
%temp_unit = 'k'; temp_val = '3800';
%reactant_amount_unit = 'wt'; reactant_temp_unit = 'k';
%fuel_name = '(CH2)x(cr)'; fuel_amount = '20'; fuel_temp = '298';
%oxid_name = 'O2'; oxid_amount = '80'; oxid_temp = '298';
%output = 'p t mw gam %f o/f phi,eq.ratio';

%list = [problem_type, pressure_unit, pressure_val, temp_unit, temp_val, reactant_amount_unit, reactant_temp_unit, fuel_name, fuel_amount, fuel_temp, oxid_name, oxid_amount, oxid_temp, output];


for i = 1:case_num
    case_data = data(i,:);
    case_inp = generate_input(case_data);
    fid = fopen(sprintf('%s%d.%s', 'case_',i, 'imp'),'wt');
    fprintf(fid, '%s', case_inp);
    fclose(fid);
end