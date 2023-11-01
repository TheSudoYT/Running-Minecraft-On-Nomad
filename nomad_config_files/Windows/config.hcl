data_dir = "F:\\nomad" # Replace with the path to a folder on your Windows PC

bind_addr = "0.0.0.0" # Keep "0.0.0.0" unless you have a specific interface you want to use.

# Client Block
client {
    enabled = true
}

# Server Block
server {
    enabled = true
    bootstrap_expect = 1
}

# Used to allow the nomad client to detect raw_exec
plugin "raw_exec" {  #https://developer.hashicorp.com/nomad/docs/drivers/raw_exec#client-requirements
    config {
        enabled = true
  }
}