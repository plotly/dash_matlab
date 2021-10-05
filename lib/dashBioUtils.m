function bioUtilsComponent = dashBioUtils(methods, properties)
    mod = py.importlib.import_module(strcat('dash_bio_utils','.',methods{1}));    
    bioUtilsComponent = mod.(methods{2})(pyargs(properties{:}));
end