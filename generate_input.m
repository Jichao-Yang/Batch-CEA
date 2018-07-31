function inp = generate_input(list)
    problem_type = list(1); problem_type = problem_type{1};
    pressure_unit = list(2); pressure_unit = pressure_unit{1};
    pressure_val = list(3); pressure_val = sprintf('%d',pressure_val{1});
    temp_unit = list(4); temp_unit = temp_unit{1};
    temp_val = list(5); temp_val = sprintf('%d',temp_val{1});
    reactant_amount_unit = list(6); reactant_amount_unit = reactant_amount_unit{1};
    reactant_temp_unit = list(7); reactant_temp_unit = reactant_temp_unit{1};
    fuel_1_name = list(8); fuel_1_name = fuel_1_name{1};
    fuel_1_amount = list(9); fuel_1_amount = sprintf('%d',fuel_1_amount{1});
    fuel_1_temp = list(10); fuel_1_temp = sprintf('%d',fuel_1_temp{1});
    fuel_2_name = list(11); fuel_2_name = fuel_2_name{1};
    fuel_2_amount = list(12); fuel_2_amount = sprintf('%d',fuel_2_amount{1});
    fuel_2_temp = list(13); fuel_2_temp = sprintf('%d',fuel_2_temp{1});
    oxid_name = list(14); oxid_name = oxid_name{1};
    oxid_amount = list(15); oxid_amount = sprintf('%d',oxid_amount{1});
    oxid_temp = list(16); oxid_temp = sprintf('%d',oxid_temp{1});
    output = list(17); output = output{1};
 
    problem_head = ['problem   ', newline];
    problem_body = ['    ', problem_type, '   ', 'p,', pressure_unit, '=', pressure_val, ',  ', 't,', temp_unit, '=', temp_val];
    problem_body = [problem_body, newline];
 
    react_head = ['react  ', newline];
    react_body_fuel_1 = ['  ', 'fuel=', fuel_1_name, ' ', reactant_amount_unit, '=', fuel_1_amount, '  ', 't,', reactant_temp_unit, '=', fuel_1_temp, '  '];
    react_body_fuel_2 = ['  ', 'fuel=', fuel_2_name, ' ', reactant_amount_unit, '=', fuel_2_amount, '  ', 't,', reactant_temp_unit, '=', fuel_2_temp, '  '];
    react_body_oxid = ['  ', 'oxid=', oxid_name, ' ', reactant_amount_unit, '=', oxid_amount, '  ', 't,', reactant_temp_unit, '=', oxid_temp, '  '];
    react_body_fuel_1 = [react_body_fuel_1, newline]; react_body_fuel_2 = [react_body_fuel_2, newline]; react_body_oxid = [react_body_oxid, newline];
    
    output_head = ['output  ', newline];
    output_body = ['    plot', ' ', output, ' '];
    output_body = [output_body, newline];
    
    end_head = ['end', newline];
    
    
    inp = [problem_head, problem_body, react_head, react_body_fuel_1, react_body_fuel_2, react_body_oxid, output_head, output_body, end_head];
end