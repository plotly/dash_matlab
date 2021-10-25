terminate(pyenv);
clearvars;

mdText = sprintf([...
    '### NglMoleculeViewer Controls\n\n',...
    '* Rotate Stage: Left-click on the viewer and move the mouse to rotate the stage.\n',...
    '* Zoom: Use the mouse scroll-wheel to zoom in and out of the viewer.\n',...
    '* Pan: Right click on the viewer to pan the stage.\n',...
    '* Individual Molecule Interaction: Left click on the molecule to interact with, then hold the ',...
    '`CTRL` key and use right and left click mouse buttons to rotate and pan individual molecules.',...
    ]);

mdComponent = Dcc('Markdown', {'children', mdText});

dropdownOptions = {...
    struct('label','1BNA','value','1BNA'),...
    struct('label','MPRO','value','MPRO'),...
    struct('label','PLPR','value','PLPR'),...
    struct('label','5L73','value','5L73'),...
    struct('label','NSP2','value','NSP2')};

dropdownComponent = Dcc('Dropdown', {...
    'id', 'default-ngl-molecule-dropdown',...
    'options', dropdownOptions,...
    'placeholder', 'Select a molecule',...
    'value', '1BNA'});

nglComponent = dashBio('NglMoleculeViewer', {...
        'id', 'default-ngl-molecule'});
    
components = {mdComponent, dropdownComponent, nglComponent};

% Callbacks
args = {...
    argsOut('default-ngl-molecule', 'data'),...
    argsOut('default-ngl-molecule', 'molStyles'),...
    argsIn('default-ngl-molecule-dropdown', 'value')};
handle = 'return_molecule';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);