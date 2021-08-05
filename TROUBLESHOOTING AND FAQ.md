# Troubleshooting and FAQ

### Installing everything you need
Any additional matlab official toolboxes are not required for work. 
...

### I'm getting an error `Cannot find function 'py.callback.callback'.`
Would pop up on every python `callback.py` error like wrong indentation, argument mismatch etc. Matlab doesn't pass most exceptions to user while running `python` code. Please execute `callback` function from `callback.py` with local `python` and placeholder arguments to check for exceptions explicitly.
...

### How to stop the server in Windows?

Open a Windows PowerShell and enter the following:
`netstat -ano | findstr :8057`

Where `8057` is the port number currently running. Then find the PID (Process Identifier).

For example, your PID could be 10476. Keep in mind that this number can be different every time you start a new server (even if it is the same port number).

To stop the server, run:

taskkill /PID 10476 /F

### Stop server on linux:
`pkill -9 MATLABPyHost`
