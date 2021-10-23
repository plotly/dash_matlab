terminate(pyenv);
clearvars;

allowedTypes = {'text';'number';'password';'email';'search';...
    'tel';'url';'range';'hidden'};
n = length(allowedTypes);

dashInputs = {n};

for i=1:n
    t = allowedTypes{i};
    dashInputs{i} = Dcc('Input', {...
        'id', sprintf('input_%s', t),...
        'type', t,...
        'placeholder', sprintf('input type %s', t)});
end

dashDiv = Html('Div', {'id', 'out-all-types'});

components = [dashInputs(:)', {dashDiv}];

% Callbacks
argInputs = {n};

for i=1:n
    t = allowedTypes{i};
    argInputs{i} = argsIn(sprintf('input_%s', t), 'value');
end

args = {argsOut('out-all-types', 'children'), argInputs};
handle = 'cb_render';
callbackDat = {args, handle};

% Start app
startDash(components, 8057, callbackDat, 'SOLAR');