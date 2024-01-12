# main.tf


module "ec2_instances" {
  source = "./modules/ec2-module"

  instance_count   = 2
  instance_types    = ["t2.micro", "t2.micro", "t2.medium"]
  ami              = "ami-03f4878755434977f"  # Specify the desired AMI
  key_name         = "public-cli-keypair" # Specify your SSH key pair name
  subnet_id        = "subnet-0b4304641787d445a"  # Specify the subnet ID where instances will be launched
  security_group_ids = ["sg-047229541250e8d82"]  # Specify security group IDs

  tags = [
    {
      Terraform   = "true"
      Environment = "dev"
      Name        = "Jenkins-Master"
    },
    {
      Terraform   = "true"
      Environment = "dev"
      Name        = "Jenkins-Slave"
    },
  ]
}
