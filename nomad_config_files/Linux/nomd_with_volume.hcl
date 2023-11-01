data_dir = "/opt/nomad" # Change to the directroy of choice on your host

bind_addr = "0.0.0.0" # Leave "0.0.0.0" unless a different interace is desired

client {
    enabled = true

    host_volume "minecraft" {
      path      = "/opt/minecraft"
      read_only = false
  }
}


server {
    enabled = true
    bootstrap_expect = 1
}