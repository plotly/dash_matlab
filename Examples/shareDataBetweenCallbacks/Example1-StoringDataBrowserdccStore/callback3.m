function table = callback3(jsonified_cleaned_data)
    dff = jsondecode(jsonified_cleaned_data);
    table = create_table(dff);
    
end