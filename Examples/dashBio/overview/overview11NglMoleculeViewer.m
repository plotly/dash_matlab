terminate(pyenv);
clearvars;

% Read data file
data_path = 'https://raw.githubusercontent.com/plotly/dash-bio-docs-files/master/';

nglData = dashBioUtils({'ngl_parser', 'get_data'}, {...
    'data_path', data_path,...
    'pdb_id', '1BNA',...
    'color', 'red',...
    'reset_view', true,...
    'local', false});

component = dashBio('NglMoleculeViewer', {...
        'id', 'my-dashbio-nglmoleculeviewer',...
        'data', {nglData}});
    
components = {component};

% Run the app
startDash(components, 8057);