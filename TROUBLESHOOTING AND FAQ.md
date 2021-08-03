# Troubleshooting and FAQ

### Installing everything you need

...

### I'm getting an error `Cannot find function 'py.callback.callback'.`

...

### How to stop the server in Windows?

Open a Windows PowerShell and enter the following:
`netstat -ano | findstr :8057`

Where `8057` is the port number currently running. Then find the PID (Process Identifier).

For example, your PID could be 10476. Keep in mind that this number can be different every time you start a new server (even if it is the same port number).

To stop the server, run:

taskkill /PID 10476 /F
