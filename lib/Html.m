function htmlComponent = Html(varargin)
% Html Constructs an dash_html_components component for dash
%
%  This expressions are equivalent:
%
%  H1 = Html('H1', {'This is an H1 component'})
%  H1 = Html('H1', {'children', 'This is an H1 component'})
    method = varargin{1}; % Div, H1, H2, etc.
    if nargin == 2
        properties = varargin{2}; % Name value pairs.
        % If the number of properties is odd,
        % make the first one the children
        if mod(length(properties),2)
            properties = ['children', properties];
        end

        htmlComponent = py.dash.html.(method)(...
            pyargs(properties{:}));
    else
        htmlComponent = py.dash.html.(method)();
    end
end
