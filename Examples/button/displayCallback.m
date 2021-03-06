function outHtml = displayCallback(btn1, btn2, btn3)
    ctx = py.dash.callback_context;
    if ~ctx.triggered
        button_id = 'None of the buttons have been clicked yet';
    else
        button_id = ctx.triggered;
    end
    
    ctx_msg = jsonencode(struct(...
        'states', ctx.states,...
        'triggered', ctx.triggered,...
        'inputs', ctx.inputs));

    tab = Html('Table', {...
        Html('Tr', {...
            Html('Th', {'Button 1'}),...
            Html('Th', {'Button 2'}),...
            Html('Th', {'Button 3'}),...
            Html('Th', {'Most Recent Click'})}),...
        Html('Tr', {...
            Html('Td', {btn1}),...
            Html('Td', {btn2}),...
            Html('Td', {btn3}),...
            Html('Td', {button_id})})});
        
    pre = Html('Pre', {ctx_msg});
    
    outHtml = Html('Div', {{tab, pre}});
    
    outHtml = char(jsonencode(outHtml));

end
