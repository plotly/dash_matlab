% Will need to be updated for multiple outputs

function output = argsOut(component_id, component_property)
    output = py.dash.dependencies.Output(pyargs(...
        'component_id', component_id,...
        'component_property', component_property));
end
