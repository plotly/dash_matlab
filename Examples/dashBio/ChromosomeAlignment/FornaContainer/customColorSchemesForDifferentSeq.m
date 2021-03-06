terminate(pyenv);
clearvars;

sequences = {...
    struct(...
        'sequence', 'AUGGGCCCGGGCCCAAUGGGCCCGGGCCCA',...
        'structure', '.((((((())))))).((((((()))))))',...
        'options', struct('name', 'PDB_01019')),...
    struct(...
        'sequence', 'GGAGAUGACgucATCTcc',...
        'structure', '((((((((()))))))))',...
        'options', struct('name', 'PDB_00598')),...
    };

customColors = struct(...
    'domain', {0, 100},...
    'range', {'rgb(175, 0, 255)', 'orange'},...
    'colorValues', struct(...
        '', struct()));

component = dashBio('FornaContainer', {...
        'sequences', sequences,...
        'colorScheme', 'positions'});  
    
components = {component};

% Run the app
startDash(components, 8057);