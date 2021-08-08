function up_graph_3 = callback4(jsonified_cleaned_data)
    datasets = jsondecode(jsonified_cleaned_data);
    dff = datasets.df_3;
    up_graph_3 = create_figure_3(dff);
    
end