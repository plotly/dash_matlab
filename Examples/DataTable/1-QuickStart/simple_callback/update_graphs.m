function value = update_graphs(active_cell)
    value = jsonencode({string(jsonencode(active_cell))});
end