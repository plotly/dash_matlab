terminate(pyenv);
clearvars;

data = readBioData('https://git.io/JVWWS', 'dataframe');

manhattan = dashBio('ManhattanPlot', {...
    'dataframe', data});

component = Dcc('Graph', {...
    'figure', manhattan});  
    
components = {component};

% Run the app
startDash(components, 8057);