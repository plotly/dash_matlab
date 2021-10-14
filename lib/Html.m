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
        % If there is only one property, make it the children.
        if length(properties) == 1
            properties = {'children', properties{1}};
        end

        htmlComponent = py.dash_html_components.(method)(...
            pyargs(properties{:}));
    else
        htmlComponent = py.dash_html_components.(method)();
    end
end
