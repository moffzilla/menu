#!/bin/sh
#echo "Starting Pidgin as container in the background"
docker start pidgin3
retval=$?

if [ $retval -eq 0 ]; then
    echo "Docker Container Starting"
  else
    echo "Docker Container not found, it will be built and started"
    cd $HOME/pidgin3
    IMAGE="moffzilla/pidgin3:latest"
    NAME="pidgin3"
    LOCAL_DATA_DIR=~/.pidgin3

   if [ ! -d "$LOCAL_DATA_DIR" ]; then
	  mkdir $LOCAL_DATA_DIR
    fi

    docker run --name="$NAME" -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	         --net=host -e PULSE_SERVER=tcp:$(hostname -i):4713 \
		        -e PULSE_COOKIE=/run/pulse/cookie \
			       -v /etc/localtime:/etc/localtime:ro \
			              -v ~/.config/pulse/cookie:/run/pulse/cookie \
				             -v $LOCAL_DATA_DIR:/home/developer/.purple -i -t $IMAGE pidgin


    exit 0
fi
