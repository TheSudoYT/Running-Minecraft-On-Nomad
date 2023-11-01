job "minecraft"{
  
    datacenters = ["dc1"]
 
    group "mc-server-java" {
       
        volume "minecraft" {
          type = "host"
          read_only = false
          source = "minecraft"
        }
      
        task "java-minecraft" {
 
            volume_mount {
              volume = "minecraft"
              destination = "/world"
              read_only = false
            }
          
            artifact {
                source = "https://raw.githubusercontent.com/TheSudoYT/Running-Minecraft-On-Nomad/main/eula.txt"
                mode = "file"
                destination = "eula.txt"
            }
            artifact {
                source = "https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar"
            }
          
            driver = "java"

            config {
                jar_path    = "local/server.jar"
                jvm_options = ["-Xmx768M", "-Xms768M"]
                args = ["nogui"]
            }
            resources {
                cpu = 4000
                memory = 4000
                disk = 8000
                network {
                    port "access" {
                        static = 25565
                    }
                }
            }
        }
    }
}