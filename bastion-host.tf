resource "aws_instance" "nitesh-bastion-server" {
  ami                    = lookup(var.AMIS, var.region )
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.nitesh-key.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.nitesh-bastion-sg.id]
  tags                   = {
    Name    = "nitesh-bastion-server"
    Project = var.projectName
  }

  provisioner "file" {
    content = templatefile("templates/db-deploy.tmpl", {
      rds-endpoint = aws_db_instance.nitesh-rds.address, dbuser = var.dbuser, dbpass = var.dbpass
    } )
    destination = "/tmp/nitesh-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nitesh-dbdeploy.sh",
      "sudo /tmp/nitesh-dbdeploy.sh"
    ]
  }
  connection {
    user        = var.username
    private_key = file(var.priv_key_path)
    host        = self.public_ip
  }
  depends_on = [aws_db_instance.nitesh-rds]
}