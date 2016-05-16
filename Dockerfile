# ninjaben/matlab-support
# 
# Create an image with enough dependencies to support a mounted-in matlab.
#
# Example usages--
#
# These examples worked on the author's dev machine.  To run them on your machine you must make some substitutions:
#   - For "/usr/local/MATLAB/R2016a" substitute your Matlab location and version.  Try "ls -al `which matlab`".
#   - For "/home/ben/Desktop/matlab-docker", substitute any folder where you want the container to write logs.
#   - For "68:f7:28:f6:68:a6", substitute the mac address associated with your Matlab license.
#
# Print Matlab command help:
# docker run --rm -v /usr/local/MATLAB/R2016a:/usr/local/MATLAB/from-host -v /home/ben/Desktop/matlab-docker:/var/log/matlab --mac-address=68:f7:28:f6:68:a6 ninjaben/matlab-support
# 
# Launch Matlab and print version info:
# docker run --rm -v /usr/local/MATLAB/R2016a:/usr/local/MATLAB/from-host -v /home/ben/Desktop/matlab-docker:/var/log/matlab --mac-address=68:f7:28:f6:68:a6 ninjaben/matlab-support -r "version,exit;"
#
# Plot a figure and save it as a png we can view from outside the container:
# sudo docker run --rm -v /usr/local/MATLAB/R2016a:/usr/local/MATLAB/from-host -v /home/ben/Desktop/matlab-docker:/var/log/matlab --mac-address=68:f7:28:f6:68:a6 ninjaben/matlab-support -r "plot(1:10);print('/var/log/matlab/figure.png', '-dpng');exit;"
# 
# Based on work by Michael Perry at Stanford.  Thanks!
#

FROM ubuntu:14.04

MAINTAINER Ben Heasly <benjamin.heasly@gmail.com>

# Matlab dependencies
RUN apt-get update && apt-get install -y \
    libpng12-dev libfreetype6-dev \
    libblas-dev liblapack-dev gfortran build-essential xorg

# run the container like a matlab executable 
ENTRYPOINT ["/usr/local/MATLAB/from-host/bin/matlab", "-logfile /var/log/matlab/matlab.log"]

# default to matlab help
CMD ["-h"]
