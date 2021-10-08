terminate(pyenv);
clearvars;

sequences = {struct(...
    'sequence', 'AUGGGCCCGGGCCCAAUGGGCCCGGGCCCA',...
    'structure', '.((((((())))))).((((((()))))))',...
    'options', struct('labelInterval', 3))};

component = dashBio('FornaContainer', {...
        'sequences', sequences});  
    
components = {component};

% Run the app
startDash(components, 8057);