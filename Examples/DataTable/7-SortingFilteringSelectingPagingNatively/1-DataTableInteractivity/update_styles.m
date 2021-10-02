function styleTable = update_styles(selected_columns)
    styleTable = {length(selected_columns)};
    for i=1:length(selected_columns)
        styleTable{i} = struct(...
            'if', struct('column_id', selected_columns{i}),...
            'background_color', '#D2F3FF');        
    end
    
    fileID = fopen('outsMat.txt','w');
    o = matlab.unittest.diagnostics.ConstraintDiagnostic.getDisplayableString(styleTable{1});
    fprintf(fileID, '%s\n', o);
    fclose(fileID);  
    
    try
        if styleTable{1} == 0
            styleTable = char(jsonencode({{}}));
        end
    catch
        styleTable = char(jsonencode({styleTable}));
    end
    


end