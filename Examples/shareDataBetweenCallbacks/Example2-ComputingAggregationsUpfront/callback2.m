function up_graph_1 = callback2(jsonified_cleaned_data)
    datasets = jsondecode(jsonified_cleaned_data);
    dff = datasets.df_1;
    up_graph_1 = create_figure_1(dff);
    
end