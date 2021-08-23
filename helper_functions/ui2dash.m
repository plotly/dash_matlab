function component = ui2dash(ui_widget, id)
    pad = 5; %padding in px
    switch ui_widget.Type
        case 'uislider'
            
            sld = ui_widget; 
            
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
            
        case 'uibuttongroup'
            butgroup = ui_widget;              
            lnbut = length(butgroup.Buttons);
            opts = {lnbut};
            if lnbut>0
                for i=1:lnbut
                     opts{i} = py.dict(pyargs('label', butgroup.Buttons(i).Text, 'value', butgroup.Buttons(i).Text));
                end
                component = py.dash_core_components.RadioItems(pyargs('id', id, ...
                            'options', opts, ...
                            'value', butgroup.Buttons(1).Text, ...
                            'labelStyle', py.dict(pyargs('display', 'inline-block')), ...
                             'style', py.dict(pyargs('padding', num2str(15)+"px")))   );
            else
                component = py.dash_core_components.RadioItems(pyargs('id', id, ...
                            'labelStyle', py.dict(pyargs('display', 'inline-block')), ...
                            'style', py.dict(pyargs('padding',  num2str(15)+"px")))   );                
            end
            
        % DropDown Properties
        case 'uidropdown'
            drpdown = ui_widget;
               
            lnbut = length(drpdown.Items);
            opts = {lnbut};
            for i=1:lnbut
                opts{i} = py.dict(pyargs('label', drpdown.Items{i}, 'value', drpdown.Items{i}));
            end

            component = py.dash_core_components.Dropdown(pyargs('id', id, ...
            'options', opts, 'value', drpdown.Value ));
        
        % Button Properties
        case 'uibutton'
            btn = ui_widget;
            component = py.dash_html_components.Button(btn.Text, pyargs(...
                'id',id, 'n_clicks', 0 ));
                
        % Lamp Properties
        case 'uilamp'
            l = ui_widget;
            if l.Enable == 'on'
                val = true;
            elseif l.Enable == 'off'
                val = false;
            end
            component = py.dash_daq.Indicator(pyargs(...
                'id',id,...
                'color', rgb2hex(l.Color),...
                'value', val));    
            

            
        % Gauge Properties
        case 'uigauge'
            g = ui_widget;
            colorRanges = py.dict();            
            for i=1:length(g.ScaleColors(:,1))                
                update(colorRanges, py.dict(pyargs(...
                    rgb2hex(g.ScaleColors(i,:)), py.list({...
                        py.int(g.ScaleColorLimits(i,1)),py.int(g.ScaleColorLimits(i,2))}))));
            end 
          
            component = py.dash_daq.Gauge(pyargs(...
                'id',id, 'value', g.Value,...
                'min', g.Limits(1), 'max', g.Limits(2),...
                'color', py.dict(pyargs(...
                    'ranges', colorRanges,...
                    'gradient', false))));
                
        % Linear Gauge Properties
        case 'uilineargauge'
            g = ui_widget;
            colorRanges = py.dict();            
            for i=1:length(g.ScaleColors(:,1))                
                update(colorRanges, py.dict(pyargs(...
                    rgb2hex(g.ScaleColors(i,:)), py.list({...
                        py.int(g.ScaleColorLimits(i,1)),py.int(g.ScaleColorLimits(i,2))}))));
            end 
          
            component = py.dash_daq.GraduatedBar(pyargs(...
                'id',id, 'value', g.Value,...
                'min', g.Limits(1), 'max', g.Limits(2),...
                'color', py.dict(pyargs(...
                    'ranges', colorRanges,...
                    'gradient', false))));
                
        % Knob Properties
        case 'uiknob'
            k = ui_widget;           
            component = py.dash_daq.Knob(pyargs(...
                'id',id, 'value', k.Value,...
                'min', k.Limits(1), 'max', k.Limits(2)));
            
        % Boolean Switch Properties
        case 'uiswitch'
            s = ui_widget;  

            component = py.dash_daq.BooleanSwitch(pyargs(...
                'id',id, 'on', false,...
                'disabled', s.Enable == 'off',...
                'vertical', s.Orientation == 'vertical'));
            
        % Toggle Switch Properties
        case 'uitoggleswitch'
            s = ui_widget;           
            component = py.dash_daq.ToggleSwitch(pyargs(...
                'id',id, 'value', false, 'size', 100,...
                'disabled', s.Enable == 'off',...
                'vertical', s.Orientation == 'vertical'));
            
        % DatePicker Properties
        case 'uidatepicker'
            dt = ui_widget;
            date1 = char(dt.Limits(1));
            date2 = char(dt.Limits(2));
            component = py.dash_core_components.DatePickerSingle(pyargs(...
                'id','my-date-picker-single',...
                'min_date_allowed',py.datetime.datetime.strptime(date1, '%m/%d/%Y'),...
                'max_date_allowed',py.datetime.datetime.strptime(date2, '%m/%d/%Y'),...
                'initial_visible_month',py.datetime.datetime.strptime(date1, '%m/%d/%Y'),...
                'date',py.datetime.datetime.strptime(date1, '%m/%d/%Y')));
        
        % CheckBox Properties
        case 'uicheckbox'
            chkbox = ui_widget;
            
            opts = {1};
            opts{1} = py.dict(pyargs('label', chkbox.Text, 'value', chkbox.Text));
            
            if chkbox.Value == false
                component = py.dash_core_components.Checklist(pyargs('id', id, ...
                    'options', opts, 'value', {})); 
            else
              
                component = py.dash_core_components.Checklist(pyargs('id', id, ...
                    'options', opts, 'value', {chkbox.Text}));
            end
            
        % TextArea Properties
        case 'uitextarea'
            txt = ui_widget;
            lenTxt = length(txt.Value);
            values = '';
            for i = 1:lenTxt-1
                values = strcat(values, txt.Value{i}, '\n');
            end
            values = strcat(values, txt.Value{lenTxt});
            values = sprintf(values);
            component = py.dash_core_components.Textarea(pyargs(...
                'id', id, ...
                'value', values, ...
                'style', py.dict(pyargs('width', '50%', 'height', 150, 'font-size', 14))));

            
        % Label Properties
        case 'uilabel'
            lbl = ui_widget;
            component = py.dash_html_components.Label(pyargs(...
                'id',id, 'children', lbl.Text));

        % Hyperlink Properties
        case 'uihyperlink'
            hlink = ui_widget;
            component = py.dash_core_components.Link(pyargs(...
                'id',id, 'href', hlink.URL, 'target', '_blank', 'children', hlink.Text));
        
        % Image Properties
        case 'uiimage'
            img = ui_widget;
            component = py.dash_html_components.Img(pyargs(...
                'id',id, 'src', img.ImageSource));

        % axes Properties
        case 'axes'
            axs = ui_widget;
            f=figure('visible','off');
            copyobj(axs,f);
            plotlyfig = plotlyfig2dash(fig2plotly(f, 'offline', true, 'open', false,'Visible',false), axs.Tag);
            close(f);            
            component = plotlyfig;
        
        % DataTable Properties for html.Table and DataTable
        case 'uitable'
            % for datatable
            if isstruct(ui_widget.UserData)
                tb = ui_widget;
                [lnrows, lncols] = size(tb.Data);

                if isfield(tb.UserData, 'customColumns')
                    cols = tb.UserData.customColumns;
                    tb.UserData = rmfield(tb.UserData, 'customColumns');
                else
                    cols = {lncols};
                    for i=1:lncols
                        cols{i} = py.dict(pyargs('name', string(tb.ColumnName(i)), 'id', string(tb.ColumnName(i))));
                    end
                end
                data = {lnrows};
                for i=1:lnrows
                    d = py.dict();
                    for j=1:lncols
                        update(d, py.dict(pyargs(string(tb.ColumnName(j)), tb.Data{i,j})));
                    end
                    data{i} = d;
                end
                items = {'id', id,...
                    'columns', py.list(cols),...
                    'data', py.list(data)};
                for item = fieldnames(tb.UserData)'
                    items{end+1} = char(item);
                    items{end+1} = tb.UserData.(char(item));
                end
                component = py.dash_table.DataTable(pyargs(items{:}));
            % for html.Table as container for other elements
            else    
                table = ui_widget;
                sz = size(table.Data);
                rows=py.list();
                for i=1:sz(1)
                    cols=py.list();
                    for j=1:sz( 2)
                        cl = py.dash_html_components.Td(pyargs( ...
                            'id', table.UserData(i, j), 'children', table.Data(i, j)));
                        cols.append(cl);
                    end                
                    rows.append(py.dash_html_components.Tr(cols));                
                end
                component = py.dash_html_components.Table(pyargs( 'children', rows));
             end
            
        % Tab group
        case 'uitabgroup'
            tabgr  = ui_widget;
            tabln = length(tabgr.Children);
            tabs = py.list();
            %tabs
            for i=1:tabln
                tb = tabgr.Children(i);
                %get tab children
                nestln = length(tb.Children());
                nest = py.list();
                %cycle through tab content
                for j=1:nestln
                    nest.append(ui2dash(tb.Children(j), tb.Children(j).Tag));
                end
                %add tab with tab content to group
                tabs.append(py.dash_core_components.Tab(pyargs( ...
                    'label', tb.Title, ...
                    'children', nest)));
            end
            %tab group
            component = py.dash_core_components.Tabs(pyargs('children', tabs, ...
                    'style', py.dict(pyargs('padding', num2str(pad)+"px"))));            
            
        %numeric edit field
        case 'uinumericeditfield'
            component = py.dash_core_components.Input(...
                pyargs('id', ui_widget.Tag, 'type', 'number', 'value', ui_widget.Value));

        %text edit field
        case 'uieditfield'
            component = py.dash_core_components.Input(...
                pyargs('id', ui_widget.Tag, 'type', 'text', 'value', ui_widget.Value));
    
    end
end
