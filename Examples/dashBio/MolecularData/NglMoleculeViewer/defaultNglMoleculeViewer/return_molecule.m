function out = return_molecule(value)
value = string(value);


    %if strcmp(value, 'NaN')
    %    out = jsonencode('PreventUpdate');
    %else
        % Read data file
        data_path = 'https://raw.githubusercontent.com/plotly/dash-bio-docs-files/master/';

        molstyles_dict = struct(...
            'representations', {'cartoon', 'axes+box'},...
            'chosenAtomsColor', 'white',...
            'chosenAtomsRadius', 1,...
            'molSpacingXaxis', 100);

        data_list = dashBioUtils({'ngl_parser', 'get_data'}, {...
            'data_path', data_path,...
            'pdb_id', value,...
            'color', 'red',...
            'reset_view', true,...
            'local', false});
        data_list = {data_list};
        
fileID = fopen('outsMat.txt','w');
%o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(data_list{1});
%fprintf(fileID, '%s\n', o);

%o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(molstyles_dict);
%fprintf(fileID, '%s\n', o);
        

        out = char(jsonencode({data_list, molstyles_dict}));
o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(out);
fprintf(fileID, '%s\n', o);
fclose(fileID);        
    %end
end

