terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVu9Q');
data = py.json.loads(char(data));

component = dashBio('OncoPrint', {...
        'data', data,...
        'colorscale', struct(...
            'MISSENSE', '#e763fa',...
            'INFRAME', '#E763FA'),...
        'backgroundcolor', '#F3F6FA'});   
    
components = {component};

% Run the app
startDash(components, 8057);