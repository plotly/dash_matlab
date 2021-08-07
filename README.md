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
Install [Dash](https://github.com/plotly/dash) plotting library:  
`pip install dash`  
____
Install [dash-bootstrap-components](https://github.com/facultyai/dash-bootstrap-components):  
`pip install dash-bootstrap-components`
____
Install [Plotly Graphing Library for MATLAB](https://plotly.com/matlab/getting-started/):
Download its sources and install in MATLAB with:  
```
cd ~/Downloads/plotly-graphing-library-for-matlab-master  
plotlysetup_offline()
```  
don't use setup with URL 
____
Add `dash_matlab` folder to MATLAB [path](https://www.mathworks.com/help/matlab/ref/addpath.html):  
`addpath('~/dash_matlab/Aux')`  
or with [GUI](https://ibb.co/HYgsPGL), add with [subfolders](https://ibb.co/tCgv3rC) `dash_matlab`:    

## Deploying on [AWS](https://aws.amazon.com/console/):
please install Matlab and other requirements from this `readme` on remote `EC2` machine and change folder to [aws_multi_input](https://github.com/plotly/dash_matlab/tree/main/Examples/aws_multi_input) example,  
run script with these commands:  
>`screen -dmS matt /matlab/bin/matlab -r comm`  
>`/matlab/bin/matlab -batch 'multi_arg(8050)' &`  
>`/matlab/bin/matlab -batch 'multi_arg(8051)' &` 

- First matlab starts with shared session for callback execution from multiple machines,  
- Second & third are app server start with `port` argument.  
- Totally we have 3 matlabs for 2 apps at 8050 and 8051 ports.  
***
Please refer to file sources for implementation details,  
Now web application can be accessed with public machine IP and port 8050!  
____
Create insightful graphs in web!


