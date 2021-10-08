terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/J2B8A');

component = dashBio('AlignmentChart', {...
        'id', 'my-default-alignment-viewer',...
        'data', data});
    
divHtml = Html('Div', {'id', 'default-alignment-viewer-output',...
    'style', struct('whiteSpace','pre-line')});    
    
components = {component, divHtml};

% Callbacks
args = {...
    argsOut('default-alignment-viewer-output', 'children'),...
    argsIn('my-default-alignment-viewer', 'eventDatum')};
handle = 'update_output';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);