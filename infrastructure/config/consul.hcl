datacenter = "dc1"
data_dir = "/opt/IotPulse/consul/work"
server = true
bootstrap_expect = 1
bind_addr = "127.0.0.1"
client_addr = "127.0.0.1"
ui = true

log_file = "/opt/IotPulse/logs/consul/consul.log"
log_rotate_bytes = 10485760  // 10MB
log_rotate_max_files = 5

ports {
  http = 8501
  dns = 8601
  server = 8301
  serf_lan = 8302
  serf_wan = 8303
}

acl {
  enabled = true
  default_policy = "deny"
  down_policy = "extend-cache"
  enable_token_persistence = true
}