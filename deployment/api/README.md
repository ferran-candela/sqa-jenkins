Simple spring API deployment
==============================

Step 1: Get Docker
~~~~~~~~~~~~~~~~~~
The first step is installing the Docker Engine. Follow the steps in the
official page: 

https://docs.docker.com/engine/getstarted/step_one/#step-1-get-docker
~~~~~~~~~~~~~~~~~~

Step 2: Build the docker image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The 'build' script is provided in order to build the docker image. No 
parameters are necessary to execute the script. Remember that docker 
need superuser privileges to be executed.

Example: 

    sudo ./build.sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Step 3: Run the docker image
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The 'run' script is provided in order to run the frontend builder. These
are the parameters that can be used:

  -n name     The instance name
  -p port     The port to bind
  -t tag      The tag of the image to instantiate.
  
Example:
               
    sudo ./run.sh -t v0.1 -p 8091 -n spring-api

~~~~~~~~~~~~~~~~~~~~~~~~~~~~

