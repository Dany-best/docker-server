# Ft_server
* This project makes us familiar with simple docker commands and working with containers
* Container consists of php my admin console, wordpress config and maria db inside of it
* Run ``docker build -t server .`` to build the container
* Run ``docker run -it --rm -p 80:80 -p 443:443 server`` to start it 
