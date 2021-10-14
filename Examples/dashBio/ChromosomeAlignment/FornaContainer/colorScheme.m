terminate(pyenv);
clearvars;

sequences = {struct(...
    'sequence', 'AUGGGCCCGGGCCCAAUGGGCCCGGGCCCA',...
    'structure', '.((((((())))))).((((((()))))))')};

component = dashBio('FornaContainer', {...
        'sequences', sequences,...
        'colorScheme', 'positions'});  
    
components = {component};

% Run the app
startDash(components, 8057);