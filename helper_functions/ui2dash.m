function component = ui2dash(ui_widget, id)

    switch ui_widget.Type
        case 'uislider'
            
            sld = ui_widget;
            
            slider_marks = py.dict();
            for i=1:length(sld.MajorTicks)
                tick = string(sld.MajorTicks(i));
                update(slider_marks, py.dict(pyargs(tick, tick)));
            end

            component = py.dash_core_components.Slider(pyargs('id', id, ...
            'min', min(sld.MajorTicks),  ...
            'max', max(sld.MajorTicks),  ...
            'value', sld.MajorTicks(1),  ...
            'marks', slider_marks, ...
            'step', round(median(diff(sld.MajorTicks)))));
    
        case 'uibuttongroup'
            butgroup = ui_widget;
              
            lnbut = length(butgroup.Buttons);
            opts = {lnbut};
            for i=1:lnbut
                 opts{i} = py.dict(pyargs('label', butgroup.Buttons(i).Text, 'value', butgroup.Buttons(i).Text));
            end
            component = py.dash_core_components.RadioItems(pyargs('id', id, ...
            'options', opts, ...
            'value', butgroup.Buttons(1).Text, ...
            'labelStyle', py.dict(pyargs('display', 'inline-block')))   );
           
        case 'uidropdown'
            drpdown = ui_widget;
               
            lnbut = length(drpdown.Items);
            opts = {lnbut};
            for i=1:lnbut
                opts{i} = py.dict(pyargs('label', drpdown.Items{i}, 'value', drpdown.Items{i}));
            end

            component = py.dash_core_components.Dropdown(pyargs('id', id, ...
            'options', opts, 'value', drpdown.Value ));
    end
end