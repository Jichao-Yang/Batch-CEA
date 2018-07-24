%# Prompt for creation
promptMessage = sprintf('Do you wish to create a new file?');
titleBarCaption = 'New Worksheet';
numberOfUsers = 1;
buttonSelections = zeros(1, numberOfUsers); % Preallocate.
for userNumber = 1 : numberOfUsers
	button = questdlg(promptMessage, titleBarCaption, 'Yes', 'No', 'Yes');
	if strcmpi(button, 'Yes')
        val = true;
    else
        val = false;
	end
end

%# delete existing file
if val == true
        %# output file name
        fName = fullfile(pwd, 'CEAdata.xls');

        %# create Excel COM Server
        Excel = actxserver('Excel.Application');
        Excel.Visible = false;

        if exist(fName, 'file'), delete(fName); end
        %# create new XLS file
        wb = Excel.Workbooks.Add();
        wb.Sheets.Item(1).Activate();
        %# save XLS file
        wb.SaveAs(fName,1);
        wb.Close(false);
end

if val == true
    answer = inputdlg('Enter number of trials:',...
                 'Sample', [1 50]);
             trials = str2num(answer{1});
    data=ones(10,4);      %Sample 2-dimensional data
    col_header={'problem_type','pressure_unit', 'pressure_val', 'temp_unit', 'temp_val', 'reactant_amount_unit','reactant_temp_unit','fuel_name','fuel_amount','fuel_temp', 'oxid_name', 'oxid_amount', 'oxid_temp', 'output'};     %Row cell array (for column labels)

    for i = 1: trials
        row_header(i,1) = {sprintf('%s_%d', 'trial', i)};
        row_headerType(i,1)={sprintf('hp')}; 
        row_headerPressure(i,1)={sprintf('bar')}; 
        row_headerTemp(i,1)={sprintf('k')}; 
    end
    xlswrite('CEAdata.xls',col_header,'Sheet1','B1');     %Write column header
    xlswrite('CEAdata.xls',row_header,'Sheet1','A2');      %Write row header
    xlswrite('CEAdata.xls',row_headerType,'Sheet1','B2');      %Write row header
    xlswrite('CEAdata.xls',row_headerPressure,'Sheet1','C2');      %Write row header
    xlswrite('CEAdata.xls',row_headerTemp,'Sheet1','E2');      %Write row header
    %# close Excel
    Excel.Quit();
end

winopen('CEAdata.xls')
