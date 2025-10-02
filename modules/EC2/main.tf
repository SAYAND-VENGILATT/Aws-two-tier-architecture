resource "aws_instance" "instance" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id = element(var.public_subnets, 0)
    vpc_security_group_ids =  [var.ec2_sg_id]

  lifecycle {
    create_before_destroy = true
  }

  
   user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "Hello" > /var/www/html/index.html
              EOF

}
