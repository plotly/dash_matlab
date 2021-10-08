terminate(pyenv);
clearvars;

sequences = {struct(...
    'sequence', 'AUGGGCCCGGGCCCAAUGGGCCCGGGCCCA',...
    'structure', '.((((((())))))).((((((()))))))')};

component = dashBio('FornaContainer', {...
        'sequences', sequences,...
        'allowPanningAndZooming', false});  
    
components = {component};

% Run the app
startDash(components, 8057);