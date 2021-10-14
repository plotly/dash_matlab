function bioUtilsComponent = dashBioUtils(methods, properties)
% dash_bio_utils component
%
%  dashBioUtils(methods, properties)
%
%  methods: cell array of strings.
%  properties: cell array containing name-value pairs with properties.
%
%  For example, a dash_bio_utils.ngl_parser.get_data(data=data) would be
%  done like:
%
%  dashBioUtils({'ngl_parser', 'get_data'}, {'data', data})
    mod = py.importlib.import_module(strcat('dash_bio_utils','.',methods{1}));    
    bioUtilsComponent = mod.(methods{2})(pyargs(properties{:}));
end