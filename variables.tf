variable "dns_name" {
  type = string
}

variable "backdoor_dns_name" {
  type = string
}

variable "aws_route53_zone_id" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}

variable "acm_certificate_arn_backdoor" {
  type = string
}

variable "github_organization" {
  type = string
}

variable "github_username" {
  type = string
}

variable "github_token" {
  type = string
}

variable "github_repo_name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "maintenance_mode_enabled" {
  type = bool
  default = false
}
