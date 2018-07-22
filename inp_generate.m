% initialization
problem_type = "hp";
pressure_unit = 'bar'; pressure_val = '8.3';
temp_unit = 'k'; temp_val = '3800';
fuel_name = '(CH2)x(cr)';
fuel_amount_unit = 'wt';
fuel_amount_val = '20';
fuel_temperature_unit = 'k';
fuel_temperature_val = '298';
 

problem_head = sprintf('problem   \n');
problem_body = sprintf('    '+problem_type+'   '...
                       +'p,'+pressure_unit+'='+pressure_val+'  '...
                       +'t,'+temp_unit+'='+temp_val+'\n');
                   
react_head = sprintf('react  \n');
react_body_fuel = sprintf('  fuel='+fuel_name +...
                          +' '+fuel_amount_unit+'='+fuel_amount_val+..
                          +'  t,k=298  ');
react_body_oxid = sprintf('  oxid=O2 wt=80  t,k=298  ');
                      
output_head = sprintf('output  ');
output_body = '    plot p t mw gam %f o/f phi,eq.ratio ';
end_head = newline;

inp = problem_head+problem_body...
      +react_head+react_body_fuel+react_body_oxid...
      +output_head+output_body...
      +end_head;