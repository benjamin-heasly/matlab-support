# matlab-support
Docker image with enough dependencies to support a mounted-in Matlab.

This docker image gives you an Ubuntu environment capable of supporting Matlab.  For licensing reasons, you must already have your own Matlab installed on the Docker host.

To run Matlab inside the container, you have to provide three things at launch time:
 - Mount in a Matlab installation at `/usr/local/MATLAB/from-host`.
 - Mount in a folder to receive the Matlab execution log at `/var/log/matlab`.
 - Spoof the container MAC address to match you own Matlab license file.

# Example usages
These expecte you to substitute some local information:
 - `MATLAB_ROOT` is your matlab installation on the Docker host, perhaps `/usr/local/MATLAB/R2016a`.
 - `MATLAB_LOGS` is optional path on the Docker host to receive Matlab logs, perhaps `~/matlab-logs`.
 - `MATLAB_MAC_ADDRESS` is the MAC address associated with your own Matlab License, of the form `00:00:00:00:00:00`.

### Print Matlab command help:
```
docker run --rm -v "$MATLAB_ROOT":/usr/local/MATLAB/from-host -v "$MATLAB_LOGS":/var/log/matlab --mac-address="$MATLAB_MAC_ADDRESS" ninjaben/matlab-support
```

### Launch Matlab and pring version info:
```
docker run --rm -v "$MATLAB_ROOT":/usr/local/MATLAB/from-host -v "$MATLAB_LOGS":/var/log/matlab --mac-address="$MATLAB_MAC_ADDRESS" ninjaben/matlab-support -r "version,exit;"
```

### Plot a figure and save it as a png in the logs folder:
```
docker run --rm -v "$MATLAB_ROOT":/usr/local/MATLAB/from-host -v "$MATLAB_LOGS":/var/log/matlab --mac-address="$MATLAB_MAC_ADDRESS" ninjaben/matlab-support -r "plot(1:10);print('/var/log/matlab/figure.png', '-dpng');exit;"
```
# Thanks
Thanks to Michael Perry at Stanford for starter code!
