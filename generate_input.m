function inp = generate_input(list)
    problem_type = list(1); problem_type = problem_type{1};
    pressure_unit = list(2); pressure_unit = pressure_unit{1};
    pressure_val = list(3); pressure_val = sprintf('%d',pressure_val{1});
    temp_unit = list(4); temp_unit = temp_unit{1};
    temp_val = list(5); temp_val = sprintf('%d',temp_val{1});
    reactant_amount_unit = list(6); reactant_amount_unit = reactant_amount_unit{1};
    reactant_temp_unit = list(7); reactant_temp_unit = reactant_temp_unit{1};
    fuel_name = list(8); fuel_name = fuel_name{1};
    fuel_amount = list(9); fuel_amount = sprintf('%d',fuel_amount{1});
    fuel_temp = list(10); fuel_temp = sprintf('%d',fuel_temp{1});
    oxid_name = list(11); oxid_name = oxid_name{1};
    oxid_amount = list(12); oxid_amount = sprintf('%d',oxid_amount{1});
    oxid_temp = list(13); oxid_temp = sprintf('%d',oxid_temp{1});
    output = list(14); output = output{1};
 
    problem_head = ['problem   ', char(10)];
    problem_body = [strcat({'    '}, problem_type, {'   '}, 'p,', pressure_unit, '=', pressure_val, {',  '}, 't,', temp_unit, '=', temp_val)];
    problem_body = [problem_body{1}, char(10)];
 
    react_head = 'react  ';
    react_body_fuel = strcat({'  '}, 'fuel=', fuel_name, {' '}, reactant_amount_unit, '=', fuel_amount, {'  '}, 't,', reactant_temp_unit, '=', fuel_temp, {'  '});
    react_body_oxid = strcat({'  '}, 'oxid=', oxid_name, {' '}, reactant_amount_unit, '=', oxid_amount, {'  '}, 't,', reactant_temp_unit, '=', oxid_temp, {'  '});
    react_body_fuel = [react_body_fuel{1}, char(10)]; react_body_oxid = [react_body_oxid{1}, char(10)];
    
    output_head = ['output  ', char(10)];
    output_body = strcat('    plot', {' '}, output, ' ');
    output_body = [output_body{1}, char(10)];
    
    end_head = ['end', char(10)];
    
    
    inp = [problem_head, problem_body, react_head, react_body_fuel, react_body_oxid, output_head, output_body, end_head];
end