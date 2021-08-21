# MATLAB components for Dash    

Dash for MATLAB® provides an interface to use the Dash library and create analytic web applications fully in MATLAB®. Create and share MATLAB® analysis with business stakeholders through Dash, the leading low-code platform for data science web apps!

## [Examples](https://github.com/plotly/dash_matlab/tree/main/Examples)

This folder contains examples of usage:
- Determine which Button Changed with `callback_context`, ([button](https://github.com/plotly/dash_matlab/tree/main/Examples/button))
- Interactive statistical scatter plot with slider, ([slider_scatter](https://github.com/plotly/dash_matlab/tree/main/Examples/slider_scatter))  
- Multi-input callback example, ([multi_input](https://github.com/plotly/dash_matlab/tree/main/Examples/multi_input))  

## [Helper_functions](https://github.com/plotly/dash_matlab/tree/main/helper_functions)

This folder contains backend helper functions:  
- addLayout.m - builds the layout for the Dash app.  
- argsIn.m - Wrapper for Dash callback input arguments.  
- argsOut.m - Wrapper for Dash callback output arguments.  
- createApp.m - Creates the Dash web server object.  
- ui2dash.m - Converts MATLAB UI components to Dash components.  
- plotlyfig2dash.m - Converts Plotly MATLAB figures to Dash Graph components.  

## Getting Started

Please make sure that you have a compatible [Python version installed](https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/support/sysreq/files/python-compatibility.pdf). If your Python version is different, consider downgrading it or using [pyenv]( https://github.com/pyenv/pyenv).

1. Install [Dash](https://github.com/plotly/dash) plotting library:  
`pip install dash`  

2. Install [dash-bootstrap-components](https://github.com/facultyai/dash-bootstrap-components):  
`pip install dash-bootstrap-components`

3. Install [Plotly Graphing Library for MATLAB](https://plotly.com/matlab/getting-started/):
Download its sources and install in MATLAB® with:  
```
cd ~/Downloads/plotly-graphing-library-for-matlab-master  
plotlysetup_offline()
```  
Don't use `plotlysetup_online()` with Dash for MATLAB®. 

4. Add `dash_matlab` folder to yourMATLAB® [path](https://www.mathworks.com/help/matlab/ref/addpath.html):  
`addpath('~/dash_matlab/helper_functions')`  
(You can also do this in the [GUI](https://ibb.co/HYgsPGL), add with [subfolders](https://ibb.co/tCgv3rC) `dash_matlab`:    

## Deploying MATLAB® Dash apps on [AWS](https://aws.amazon.com/console/):

Please install Matlab and other requirements from this `readme` on remote `EC2` machine and change folder to [aws_multi_input](https://github.com/plotly/dash_matlab/tree/main/Examples/aws_multi_input) example,  
run script with these commands:  

>`screen -dmS matt /matlab/bin/matlab -r comm`  
>`/matlab/bin/matlab -batch 'multi_arg(8050)' &`  
>`/matlab/bin/matlab -batch 'multi_arg(8051)' &` 

- In the first command, MATLAB® starts with shared session for callback execution from multiple machines,  
- In the 2nd and 3rd commans, the Dash app server start with `port` arguments (ports 8050 and 8051).  
- In total, we have 3 MATLAB® instances running for 2 Dash apps at ports 8050 and 8051.  

Now Dash web applications can be accessed from any public machine IP and port 8050! Please refer to the [file source code] (https://github.com/plotly/dash_matlab/tree/main/Examples/aws_multi_input) for further implementation details.
