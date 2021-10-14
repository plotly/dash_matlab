terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVwry');

data = dashBioUtils({'xyz_reader','read_xyz'},...
    {'datapath_or_datastring', data, 'is_datafile', false});

component = dashBio('Speck', {...
        'id', 'my-dashbio-speck',...
        'view', struct('resolution', 600),...
        'data', data});
    
components = {component};

% Run the app
startDash(components, 8057);