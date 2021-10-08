function out = show_selected_atoms(atom_ids)
    if isempty(atom_ids) || any(strcmp(atom_ids, "NaN"))
        out = jsonencode({sprintf(...
            'No atom has been selected. Click somewhere on the molecular structure to select an atom.')});
    else
        modelData = readBioData('https://git.io/JV8hc', 'noutf8');
        out = '';
        
        for i=1:numel(atom_ids)
            atm = atom_ids{i};
            out = sprintf(strcat(out,...
                sprintf('\n\nElement: %s', string(modelData{'atoms'}{atm}{'element'})),...
                sprintf('\nChain: %s', string(modelData{'atoms'}{atm}{'chain'})),...
                sprintf('\nResidue name: %s', string(modelData{'atoms'}{atm}{'residue_name'}))));
        end
        
        out = jsonencode({out});
    end
end
