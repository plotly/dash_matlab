% callback states
function input = argState(component_id, component_property)
    input = py.dash.dependencies.State(pyargs(...
        'component_id', component_id,...
        'component_property', component_property));
end