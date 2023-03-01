#! /bin/sh

start()
{
    gpioset 0 7=1
    sleep 0.01
    gpioset 0 7=0
}

stop()
{
    :
}

if [ "$1" = "--start" ]; then
    start
elif [ "$1" = "--stop" ]; then
    stop
fi