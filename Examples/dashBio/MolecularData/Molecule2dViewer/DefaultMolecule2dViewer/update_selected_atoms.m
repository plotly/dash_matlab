function outTxt = update_selected_atoms(ids)
    if isempty(ids) || any(strcmp(ids, "NaN"))
        outTxt = jsonencode({sprintf(...
            'No atom has been selected. Select atoms by clicking on them.')});
    else
        n = sprintf(' %d,', ids{:});
        outTxt = jsonencode({sprintf(...
            strcat('Selected atom IDs: ', n(1:end-1), '.'))});        
    end
end

