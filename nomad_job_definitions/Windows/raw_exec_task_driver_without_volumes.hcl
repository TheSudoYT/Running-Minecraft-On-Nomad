# This template creats the eula.txt, downloads minecraft server.jar, and uses powershell to execute java and start minecraft.


job "minecraft-raw-exec-working" {
  
  datacenters = ["dc1"]															  # The Nomad Datacenter that this job runs on
  
  # The group block defines a series of tasks that should be co-located on the same Nomad client. 
  # Any task within a group will be placed on the same client
  group "minecraft-raw-exec-working" {
    
    # The task block creates an individual unit of work, such as a Docker container, web application, or batch processing.
    # The task to template the eula, download, and start the minecraft server
    task "eula-and-start-minecraft" {
      
      # The template block instantiates an instance of a template renderer.
  		# Tempalte the string eula=true into the eula.txt file
      template {
        data        = "eula=true"											# The data to template and put into a file
        destination = "local\\eula.txt"								# The file to template and put the data into
      }
      
      # The artifact block instructs Nomad to fetch and unpack a remote resource, such as a file, tarball, or binary.
      # Download the minecraft server.jar file from the url provided
      artifact {
        source = "https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar"
        destination = "\\local"
      }
      
      # Change into the local dirctory and execute the command to start the minecraft server.
      driver = "raw_exec"
      config {
        command = "powershell"
        args    = ["-Command", "cd local; java -jar server.jar nogui"]
      }

      # The resources block describes the requirements a task needs to execute. Resource requirements include memory, CPU, and more.
      resources {
        cpu    = 4000
        memory = 4096
      }
    }
    task "exit-minecraft" {
      
      lifecycle {
      	hook = "poststop"
    	}
      
      # Change into the local dirctory and execute the command to start the minecraft server.
      driver = "raw_exec"
      config {
        command = "powershell"
        args    = ["-Command", "Stop-Process -Name 'java' -Force"]
      }

      # The resources block describes the requirements a task needs to execute. Resource requirements include memory, CPU, and more.
      resources {
        cpu    = 4000
        memory = 4096
      }
    }
  }
}