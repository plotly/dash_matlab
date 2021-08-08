function figu = callback2(jsonified_cleaned_data)
    dff = jsondecode(jsonified_cleaned_data);
    figu = create_figure(dff);
    
end