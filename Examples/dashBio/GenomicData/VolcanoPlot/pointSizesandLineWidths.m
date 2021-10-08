terminate(pyenv);
clearvars;

data = readBioData('https://git.io/JVwyx', 'dataframe');

volcano = dashBio('VolcanoPlot', {...
    'dataframe', data,...
    'point_size', 10,...
    'effect_size_line_width', 4,...
    'genomewideline_width', 2});

component = Dcc('Graph', {...
    'figure', volcano});  
    
components = {component};

% Run the app
startDash(components, 8057);