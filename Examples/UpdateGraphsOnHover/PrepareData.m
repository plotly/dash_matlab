function countryindicators = PrepareData(filename, dataLines)
%IMPORTFILE Import data from a text file
%  COUNTRYINDICATORS = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  COUNTRYINDICATORS = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  countryindicators = PrepareData("path/to/country_indicators.csv", [2, Inf]);
%
%  See also READTABLE.
%

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["CountryName", "IndicatorName", "Year", "Value"];
opts.VariableTypes = ["categorical", "categorical", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["CountryName", "IndicatorName"], "EmptyFieldRule", "auto");

% Import the data
countryindicators = readtable(filename, opts);

end