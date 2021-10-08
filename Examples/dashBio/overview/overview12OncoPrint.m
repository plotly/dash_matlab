terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVu9Q');
data = py.json.loads(char(data));

component = dashBio('OncoPrint', {...
        'id', 'my-dashbio-oncoprint',...
        'data', data});
    
components = {component};

% Run the app
startDash(components, 8057);