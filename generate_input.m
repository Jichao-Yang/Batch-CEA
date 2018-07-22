function inp = generate_input(list)

problem_type = list(1);             problem_type = string(problem_type{1});
pressure_unit = list(2);            pressure_unit = string(pressure_unit{1});
pressure_val = list(3);             pressure_val = string(pressure_val{1});
temp_unit = list(4);                temp_unit = string(temp_unit{1});
temp_val = list(5);                 temp_val = string(temp_val{1});
reactant_amount_unit = list(6);     reactant_amount_unit = string(reactant_amount_unit{1});
reactant_temp_unit = list(7);       reactant_temp_unit = string(reactant_temp_unit{1});
fuel_name = list(8);                fuel_name = string(fuel_name{1});
fuel_amount = list(9);              fuel_amount = string(fuel_amount{1});
fuel_temp = list(10);               fuel_temp = string(fuel_temp{1});
oxid_name = list(11);               oxid_name = string(oxid_name{1});
oxid_amount = list(12);             oxid_amount = string(oxid_amount{1});
oxid_temp = list(13);               oxid_temp = string(oxid_temp{1});
output = list(14);                  output = string(output{1});

problem_head = strcat('problem   ','\n');
problem_body = strcat({'    '},problem_type,{'   '},'p,',pressure_unit,'=',pressure_val,{',  '},'t,',temp_unit,'=',temp_val,'\n');

react_head = strcat('react  ','\n');
react_body_fuel = strcat({'  '},'fuel=',fuel_name,{' '},reactant_amount_unit,'=',fuel_amount,{'  '},'t,',reactant_temp_unit,'=',fuel_temp,{'  '},'\n');
react_body_oxid = strcat({'  '},'oxid=',oxid_name,{' '},reactant_amount_unit,'=',oxid_amount,{'  '},'t,',reactant_temp_unit,'=',oxid_temp,{'  '},'\n');

output_head = strcat('output  ','\n');
output_body = strcat('    plot',{' '},output,' ','\n');

end_head = strcat('end','\n');

inp = compose(problem_head+problem_body+react_head+react_body_fuel+react_body_oxid+output_head+output_body+end_head);