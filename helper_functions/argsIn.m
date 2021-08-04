% Will need to be updated for multiple inputs

function input = argsIn(component_id, component_property)
    input = py.dash.dependencies.Input(pyargs(...
        'component_id', component_id,...
        'component_property', component_property));
end