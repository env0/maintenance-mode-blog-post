//Making this a static output due to this bug in Terraform - http://bit.ly/34uGdOz
output "website_endpoint" {
  value = aws_route53_record.dns_record.fqdn
}

output "maintenance_mode_backdoor" {
  value =  aws_route53_record.dns_backdoor_record.fqdn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.website_bucket.id
}

output "github_maintenance_mode_repo_name" {
  value = github_repository.maintenance-mode-repo[0].name
}
