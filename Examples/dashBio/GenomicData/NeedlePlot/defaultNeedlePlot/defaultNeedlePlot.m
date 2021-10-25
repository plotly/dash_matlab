terminate(pyenv);
clearvars;

% Read data file
data = readBioData('https://git.io/JVRcs');
mdata = jsondecode(char(data));

dropdown = Dcc('Dropdown', {...
    'id', 'default-needleplot-rangeslider',...
    'options', {...
        struct('label', 'Show', 'value', 1),...
        struct('label', 'Hide', 'value', 0)},...
    'clearable', false,...
    'multi', false,...
    'value', 1,...
    'style', struct('width', '400px')});

component = dashBio('NeedlePlot', {...
        'id', 'dashbio-default-needleplot',...
        'mutationData', mdata,...
        'rangeSlider', 1});
    
components = {dropdown, component};

% Callbacks
args = {...
    argsOut('dashbio-default-needleplot', 'rangeSlider'),...
    argsIn('default-needleplot-rangeslider', 'value')};
handle = 'update_needleplot';
callbackDat = {args, handle};

% Run the app
startDash(components, 8057, callbackDat);