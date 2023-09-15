packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "my_packer_image" {
  ami_name      = "my_packer_image"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami    = "ami-024e6efaf93d85776"
  ssh_username = "ubuntu"
}

build {
  name    = "my_packer_image"
  sources = [
    "source.amazon-ebs.my_packer_image"
  ]
}
provisioner "shell" {
  
  inline = [
    "sleep 30",
    "Sudo su",
    "sudo apt-get update && apt-get upgrade -y",
    "sudo apt-get update -y",
    "sudo apt-get install tomcat9-admin tomcat9-common -y",
    "sudo apt-get install tomcat9 -y"
    "cd /var/lib/tomcat9/webapps/"
    "sudo wget https://mybucket-namu.s3.us-east-2.amazonaws.com/myapp.war",
    "sudo systemctl start tomcat9"
  ]
}
