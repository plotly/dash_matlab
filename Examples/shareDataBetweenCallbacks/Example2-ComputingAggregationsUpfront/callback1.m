function json_datasets = callback1(value)
    % an expensive query step
    cleaned_df = your_expensive_clean_or_compute_step(value);
    
    % a few filter steps that compute the data
    % as it's needed in the future callbacks
    df_1 = cleaned_df(cleaned_df.fruit == 'apples', :);
    df_2 = cleaned_df(cleaned_df.fruit == 'oranges', :);
    df_3 = cleaned_df(cleaned_df.fruit == 'figs', :);
    
    datasets = py.list(pyargs(...
        'df_1', jsonencode(df_1),...
        'df_2', jsonencode(df_2),...
        'df_3', jsonencode(df_3)));
    
    json_datasets = jsonencode(datasets);
end