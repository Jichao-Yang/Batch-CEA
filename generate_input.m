function inp = generate_input(problem_type, pressure_unit, pressure_val, temp_unit, temp_val, reactant_amount_unit, reactant_temp_unit, fuel_name, fuel_amount, fuel_temp, oxid_name, oxid_amount, oxid_temp, output)

problem_head = strcat('problem   ','\n');
problem_body = strcat({'    '},problem_type,{'   '},'p,',pressure_unit,'=',pressure_val,{',  '},'t,',temp_unit,'=',temp_val,'\n');

react_head = strcat('react  ','\n');
react_body_fuel = strcat({'  '},'fuel=',fuel_name,{' '},reactant_amount_unit,'=',fuel_amount,{'  '},'t,',reactant_temp_unit,'=',fuel_temp,{'  '},'\n');
react_body_oxid = strcat({'  '},'oxid=',oxid_name,{' '},reactant_amount_unit,'=',oxid_amount,{'  '},'t,',reactant_temp_unit,'=',oxid_temp,{'  '},'\n');

output_head = strcat('output  ','\n');
output_body = strcat('    plot',{' '},output,' ','\n');

end_head = strcat('end','\n');

inp = compose(problem_head+problem_body+react_head+react_body_fuel+react_body_oxid+output_head+output_body+end_head);