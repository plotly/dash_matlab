function component1 = update_clustergram(rows)
    if length(rows) < 2
        component1 = jsonencode({sprintf('Please select at least two rows to display.')});
    else
        df = readBioData('https://git.io/Ja6zV', 'dataframe',...
            {'sep', '\t', 'skiprows', int8(4)}).set_index('model');

        cols = py.list(df.columns.values);
        row_labels = py.list(df.index.values);
        
        clustergram = dashBio('Clustergram',{...
                    'data', df.loc(rows).values,...
                    'column_labels', cols,... 
                    'row_labels', rows,...                     
                    'color_threshold', struct(...
                        'row', 250,...
                        'col', 700),...
                    'hidden_labels', 'row',...
                    'height', 800,...
                    'width', 700});
        
        component1 = Dcc('Graph',{...
            'figure', clustergram});
        
        component1 = plotlyJsonEncoder(component1);

    end
end

