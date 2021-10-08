terminate(pyenv);
clearvars;

sequences = {struct(...
    'sequence', 'AUGGGCCCGGGCCCAAUGGGCCCGGGCCCA',...
    'structure', '.((((((())))))).((((((()))))))')};

component = dashBio('FornaContainer', {...
        'sequences', sequences,...
        'nodeFillColor', 'pink'});  
    
components = {component};

% Run the app
startDash(components, 8057);