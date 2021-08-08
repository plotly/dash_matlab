function up_graph_2 = callback3(jsonified_cleaned_data)
    datasets = jsondecode(jsonified_cleaned_data);
    dff = datasets.df_2;
    up_graph_2 = create_figure_2(dff);
    
end