job "minecraft" {
  
  datacenters = ["dc1"]
  
  group "mc" {

    network {
      port "mc-vanilla-port" {
        to = 25565
        static = 25565
      }
      port "mc-vanilla-rcon" {
        to = 25575
        static = 25575
      }
      mode = "bridge"
    }

    volume "minecraft" {
      type = "host"
      read_only = false
      source = "minecraft"
    }


    task "minecraft-server-start" {
      driver = "docker"
      
      volume_mount {
        volume = "minecraft"
        destination = "/data"
        read_only  = false
      }
      
      config {
        image = "itzg/minecraft-server"
        ports = ["mc-vanilla-port","mc-vanilla-rcon"]
      }
      resources {
        cpu    = 4000
        memory = 4096
      }
      env {
        EULA = "TRUE"
      } 
    }

  }
}