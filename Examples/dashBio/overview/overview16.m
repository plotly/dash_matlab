terminate(pyenv);
clearvars;

data = readBioData('https://git.io/JVwyx', 'dataframe');

volcano = dashBio('VolcanoPlot', {...
    'dataframe', data});

component = Dcc('Graph', {...
    'figure', volcano});  
    
components = {component};

% Run the app
startDash(components, 8057);