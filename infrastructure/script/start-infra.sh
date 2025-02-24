#!/bin/bash
source ~/.bashrc
source ../env/*

# start consul
CONSUL_PID_FILE=../consul/consul.pid
CONSUL_BOOTSTRAP_FILE=../consul/bootstrap.token
if [ -f $CONSUL_BOOTSTRAP_FILE ]; then
  rm $CONSUL_BOOTSTRAP_FILE
  rm -rf ../consul/work
  echo "clean old consul data"
fi

consul agent -config-file=../static/consul.hcl > /dev/null 2>&1 &
consul_pid=$!
echo $consul_pid > $CONSUL_PID_FILE

while ! curl -s http://127.0.0.1:8501/v1/status/leader > /dev/null; do
  echo "Waiting for Consul to start..."
  sleep 5
done

consul acl bootstrap > $CONSUL_BOOTSTRAP_FILE

CONSUL_TOKEN=$(grep SecretID $CONSUL_BOOTSTRAP_FILE | awk '{print $2}')
echo "got consul token $CONSUL_TOKEN"
sed -i "s/token = \"[^\"]*\"/token = \"$CONSUL_TOKEN\"/g" ../static/nomad.hcl

#start nomad
NOMAD_PID_FILE=../nomad/nomad.pid
NOMAD_BOOTSTRAP_FILE=../nomad/bootstrap.token
if [ -f $NOMAD_BOOTSTRAP_FILE ]; then
  rm $NOMAD_BOOTSTRAP_FILE
  rm -rf ../nomad/work
  echo "clean old nomad data"
fi
nomad agent -config=../static/nomad.hcl > /dev/null 2>&1 &
nomad_pid=$!
echo $nomad_pid > $NOMAD_PID_FILE

while ! curl -s http://127.0.0.1:4646/v1/status/leader > /dev/null; do
  echo "Waiting for Nomad to start..."
  sleep 5
done

nomad acl bootstrap > $NOMAD_BOOTSTRAP_FILE

exit 0