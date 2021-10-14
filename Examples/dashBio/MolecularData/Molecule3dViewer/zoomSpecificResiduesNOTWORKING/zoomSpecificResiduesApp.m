terminate(pyenv);
clearvars;

% Read data files
modelData = readBioData('https://git.io/JV8hc', 'noutf8');
stylesData  = readBioData('https://git.io/JV4er', 'noutf8');

atoms = modelData{'atoms'};
names = {};
for atom=atoms
    if ~any(strcmp(names, string(atom{1}{'residue_name'})))
        names{end+1} = string(atom{1}{'residue_name'});
    end
    %string(atom{1}{'residue_name'})
    %asd
end
names
asd

componentMolecule = dashBio('Molecule3dViewer', {...
        'id', 'zoomfactor-molecule3d',...
        'styles', stylesData,...
        'modelData', modelData});

slider = uislider(...
    'MajorTicks', [0.4,0.8,1.2,1.6,2.0],...
    'Value', 0.8);
uiSlider = ui2dash(slider, 'zoomfactor-slider');
    
components = {componentMolecule, uiSlider};

% Callbacks
args = {...
    argsOut('zoomfactor-molecule3d', 'zoom'),...
    argsIn('zoomfactor-slider', 'value')};
handle = 'zoom';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);