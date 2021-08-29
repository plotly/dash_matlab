function styleTable = callback1(selected_columns)
    styleTable = {length(selected_columns)};
    for i=1:length(selected_columns)
        styleTable{i} = struct(...
            'if', struct('column_id', selected_columns{i}),...
            'background_color', '#D2F3FF');        
    end

    styleTable = jsonencode(styleTable);
end