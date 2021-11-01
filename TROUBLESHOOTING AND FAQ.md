# Troubleshooting and FAQ

### MATLAB version
MATLAB 2021 is the recommended version for this library. For earlier versions you may experience undesired crashes in your apps.

### Installing everything you need
Any additional Matlab official toolboxes are not required for work. 
...
### Commonly Used Matlab Startup [Options](https://www.mathworks.com/help/matlab/matlab_env/commonly-used-startup-options.html):
[Windows  ](https://www.mathworks.com/help/matlab/ref/matlabwindows.html),   [macOS  ](https://www.mathworks.com/help/matlab/ref/matlabmacos.html),   [Linux](https://www.mathworks.com/help/matlab/ref/matlablinux.html).  
can be useful:  
`-noFigureWindows` (suppresses all figure windows),  
`-batch statement` (lightweight startup for console running),  
`-nojvm` (also lighter, but some functions aren't available). 
### I'm getting an error Cannot find function `py.callback.callback`.
Would pop up on every python `callback.py` error like wrong indentation, argument mismatch etc. Matlab doesn't pass most exceptions to user while running `python` code. Please execute `callback` function from `callback.py` with local `python` and placeholder arguments to check for exceptions explicitly.

### How to run/stop the server in Windows?
On Matlab, run the following on the command window, where `helloWorld` is the name of the Matlab script you want to run (the path to MATLAB.exe may be different for your PC):

`!"C:\Program Files\Polyspace\R2021a\bin\win64\MATLAB.exe" -batch "helloWorld"`

The Dash app will be running on the specified port, and you can stop it with **Ctrl+C**.

### Stop server on linux:
`pkill -9 MATLABPyHost`
