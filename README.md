# MATLAB components for Dash    
Dash for MATLAB provides interface to use Dash library and create analytic web applications fully in MATLAB.
## [Examples](https://github.com/plotly/dash_matlab/tree/main/Examples)
contains examples of usage:
- Determining which Button Changed with `callback_context`, ([button](https://github.com/plotly/dash_matlab/tree/main/Examples/button))
- Interactive statistical scatter plot with slider, ([slider_scatter](https://github.com/plotly/dash_matlab/tree/main/Examples/slider_scatter))  
- Multi input callback example, ([multi_input](https://github.com/plotly/dash_matlab/tree/main/Examples/multi_input))  
...
## [helper_functions](https://github.com/plotly/dash_matlab/tree/main/helper_functions)
Contains backend helper functions:  
- addLayout.m - builds the layout for the Dash app.  
- argsIn.m - Wrapper for Dash callback input arguments.  
- argsOut.m - Wrapper for Dash callback output arguments.  
- createApp.m - Creates the Dash web server object.  
- ui2dash.m - Converts MATLAB UI components to Dash components.  
- plotlyfig2dash.m - Converts Plotly MATLAB figures to Dash Graph components.  
____
## Getting Started
Please be sure to use compatible [Python version](https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/support/sysreq/files/python-compatibility.pdf).  
if your Python version is different, consider downgrading it or using [pyenv]( https://github.com/pyenv/pyenv  ).
____
Install [Dash](https://github.com/plotly/dash) plotting library.  
`pip install dash`  
____
Install [Plotly Graphing Library for MATLAB](https://plotly.com/matlab/getting-started/).
Download its sources and install in MATLAB with:  
```
cd ~/Downloads/plotly-graphing-library-for-matlab-master  
plotlysetup_offline()
```  
don't use setup with URL 
____
Add `dash_matlab` folder to MATLAB [path](https://www.mathworks.com/help/matlab/ref/addpath.html)  
`addpath('~/dash_matlab/Aux')`  
or with [GUI](https://ibb.co/HYgsPGL), add with [subfolders](https://ibb.co/tCgv3rC) `dash_matlab`:    

____
Create insightful graphs in web!


