# create repo on gtihub
```
echo "# tech-challenge-2" >> README.md
```
```
git init
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

# command for main.tf
```
module "ec2" {
  source = "git::https://github.com/IntotheCloudz-bit/terraform-ec2-modules.git"

  key_name           = "Key pair name"
  subnet_id          = module.vpc.private_subnet_ids[0]
  security_group_ids = [module.vpc.ec2_security_group_id]
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