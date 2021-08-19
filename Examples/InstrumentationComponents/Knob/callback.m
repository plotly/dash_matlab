function val = callback(value)
    %msg = fprintf('The knob value is %d', value);
    msg = sprintf('The knob value is %0.2f', value);
    val = jsonencode(msg);
end
