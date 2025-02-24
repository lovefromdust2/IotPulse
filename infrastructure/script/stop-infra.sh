#!/bin/bash

CONSUL_PID_FILE=../consul/consul.pid
NOMAD_PID_FILE=../nomad/nomad.pid

if [ -f $CONSUL_PID_FILE ]; then
    cat $CONSUL_PID_FILE | xargs kill -9
    rm $CONSUL_PID_FILE
    echo "consul stopped"
  else
    echo "can't find consul service, maybe not running"
fi

if [ -f $NOMAD_PID_FILE ]; then
    cat $NOMAD_PID_FILE | xargs kill -9
    rm $NOMAD_PID_FILE
    echo "nomad stopped"
  else
    echo "can't find nomad service, maybe not running"
fi


