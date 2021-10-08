terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVwry');

data = dashBioUtils({'xyz_reader','read_xyz'},...
    {'datapath_or_datastring', data, 'is_datafile', false});

component = dashBio('Speck', {...
    'data', data,...
    'scrollZoom', true});
    
components = {component};

% Run the app
startDash(components, 8057);