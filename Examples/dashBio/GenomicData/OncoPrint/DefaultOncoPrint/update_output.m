function out = update_output(event_data)   
%fileID = fopen('outsMat.txt','w');
%o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(event_data);
%fprintf(fileID, '%s\n', o);

    if strcmp(event_data, 'NaN') || len(event_data) == 0
        s = 'There are no event data. Hover over or click on a part of the graph to generate event data.';
    end
    out = char(jsonencode({event_data}));
    
%o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(out);
%fprintf(fileID, '%s\n', o);
%fclose(fileID);    
end
