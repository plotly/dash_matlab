terminate(pyenv);
clearvars;

component = dashBio('Ideogram', {...
        'id', 'ideogram-annotations',...
        'chromosomes', {'X', 'Y'},...
        'annotationsPath', 'https://eweitz.github.io/ideogram/data/annotations/SRR562646.json'});  
    
components = {component};

% Run the app
startDash(components, 8057);