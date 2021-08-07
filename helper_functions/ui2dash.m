function component = ui2dash(ui_widget, id)

    switch ui_widget.Type
        case 'uislider' 
            
            sld = ui_widget 
            tab = readtable('dat.csv');
            slider_marks = py.dict();
            for i=1:length(sld.MajorTicks)
                tick = string(sld.MajorTicks(i));
                update(slider_marks, py.dict(pyargs(tick, tick)));
            end
            
            component = py.dash_core_components.Slider(pyargs('id',id, ...
                'min', min(sld.MajorTicks),  ...
                'max', max(sld.MajorTicks),  ...
                'value', min(sld.Value),  ...
                'marks', slider_marks, ...
                'step', round(max(sld.MajorTicks)/length(sld.MajorTicks))));
          
        case 'uitable' 
            %%%Adding uitable%%
           % table = ui_widget          
            %py.dash_html_components.Data = table
            component = py.dash_html_components.Table(pyargs('id',id+1))
            
            
end
