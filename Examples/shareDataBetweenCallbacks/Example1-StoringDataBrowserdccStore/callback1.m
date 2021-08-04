function cleaned_df = callback1(value)
    cleaned_df = your_expensive_clean_or_compute_step(value);
    cleaned_df = jsonenconde(cleaned_df);
    
end