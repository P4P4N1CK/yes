#!/bin/bash
SERVICE_NAME="MpdPLayer Service"
PATH_TO_JAR=/opt/mpdplayer/mpdplayer.jar
JAR_DIR=/opt/mpdplayer
PID_PATH_NAME=/tmp/mpdplayer-pid
MY_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
JAVA_OPTS="-Xmx8096m -XX:ActiveProcessorCount=4"
case $1 in
    start)
        echo "Starting $SERVICE_NAME ..."
                    if [ ! -f $PID_PATH_NAME ]; then
                        cd $JAR_DIR
                        nohup java $JAVA_OPTS -jar mpdplayer.jar 2>> /dev/null >> /dev/null &
                        echo $! > $PID_PATH_NAME-$port
                        echo "$SERVICE_NAME started on port $port ..."
                        sleep 2
                    else
                        echo "$SERVICE_NAME is already running ..."
                    fi
    ;;
    stop)

                if [ -f $PID_PATH_NAME ]; then
                    PID=$(cat $PID_PATH_NAME);
                    echo "$SERVICE_NAME stoping ..."
                    kill $PID;
                    echo "$SERVICE_NAME stopped ..."
                    rm $PID_PATH_NAME
                else
                    echo "$SERVICE_NAME is not running ..."
                fi

    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "$SERVICE_NAME stopping ...";
            kill $PID;
            echo "$SERVICE_NAME stopped ...";
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..."
            cd $JAR_DIR
            nohup java $JAVA_OPTS -jar mpdplayer.jar 2>> /dev/null >> /dev/null &
                        echo $! > $PID_PATH_NAME
            echo "$SERVICE_NAME started ..."
        else
            echo "$SERVICE_NAME is not running ..."
        fi
    ;;
    
    esac
    