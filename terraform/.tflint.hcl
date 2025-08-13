plugin "aws" {
  enabled = true
  version = "0.42.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_db_instance_invalid_engine" {
  enabled = true
}

# EBS encryption
rule "aws_alb_invalid_security_group" {
  enabled = true
}

# RDS security
rule "aws_db_instance_invalid_parameter_group" {
  enabled = true
}

# EC2 security
rule "aws_db_instance_invalid_vpc_security_group" {
  enabled = true
}
