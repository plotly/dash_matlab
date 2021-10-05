function dataOut = readBioData(varargin)
    data = varargin{1};
    
    if nargin >= 2
        option = varargin{2};
        switch option
            case 'dataframe'
                if nargin == 3
                    params = varargin{3};                    
                    dataOut = py.pandas.read_csv(pyargs(...
                        'filepath_or_buffer', data, params{:}));
                else
                    dataOut = py.pandas.read_csv(data);
                end
                
            case 'noutf8'
                readData = py.urllib.request.urlopen(data).read();
                dataOut = string(readData.decode());
                dataOut = py.json.loads(dataOut);
        end
    else
    readData = py.urllib.request.urlopen(data).read();
    dataOut = string(readData.decode('utf-8'));
    end
end

