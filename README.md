# create repo on gtihub

```
echo "# tech-challenge-2" >> README.md
```
```
git init
```
```
gh repo create IntotheCloudz-bit/buildops \
  --private \
  --source=. \
  --remote=origin \
  --description "Production-style AWS Cloud DevOps SRE Platform"
```
```
git add README.md
```
```
git commit -m "first commit"
```
```
git branch -M main
```
```
git remote add origin https://github.com/IntotheCloudz-bit/tech-challenge-2.git
```
```
git push -u origin main
```

# example of command
```
gh repo create terraform-ec2-modules --public --source=. --remote=origin --push
```
```
# command for main.tf

module "vpc" {
  source = "git::https://github.com/IntotheCloudz-bit/terraform-ec2-modules.git//vpc"

  name = "migration"
}

module "sg" {
  source = "git::https://github.com/IntotheCloudz-bit/terraform-ec2-modules.git//SG"

  name   = "migration-web-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "ec2" {
  source = "git::https://github.com/IntotheCloudz-bit/terraform-ec2-modules.git//ec2"

  name                   = "migration-web-server"
  subnet_id              = module.vpc.public_subnet_ids[0]
  security_group_ids     = [module.sg.security_group_id]
  key_name               = "YOUR_EXISTING_KEY_PAIR_NAME"
  associate_public_ip_address = true
}

```
# for provider.tf
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "migration"
      Environment = "devops"
      ManagedBy   = "Terraform"
    }
  }
}
```