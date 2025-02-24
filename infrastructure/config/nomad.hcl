data_dir  = "/opt/IotPulse/nomad/work"

bind_addr = "127.0.0.1" # the default

advertise {
    # Defaults to the first private IP address.
    http = "127.0.0.1"
    rpc  = "127.0.0.1"
    serf = "127.0.0.1:4648" # non-default ports may be specified
}
ports {
    http = 4646
}

server {
    enabled = true
    bootstrap_expect = 3
    logging {
        log_level = "INFO"
        log_file = "/opt/IotPulse/logs/nomad/nomad.log"
    }
}

client {
    enabled = true
}



plugin "raw_exec" {
  config {
    enabled = true
  }
}

consul {
    address = "127.0.0.1:8501"
    token = "${CONSUL_TOKEN}"
}

acl {
    enabled = true
}

