terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVu9Q');
data = py.json.loads(char(data));

component = dashBio('OncoPrint', {...
        'id', 'dashbio-default-oncoprint',...
        'data', data});
    
divHtml = Html('Div', {'id', 'default-oncoprint-output',...
    'style', struct('whiteSpace','pre-line')});     
    
components = {component};

% Callbacks
args = {...
    argsOut('default-oncoprint-output', 'children'),...
    argsIn('dashbio-default-oncoprint', 'eventDatum')};
handle = 'update_output';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);