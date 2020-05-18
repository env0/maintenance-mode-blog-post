resource "aws_route53_record" "dns_record" {
  zone_id = var.aws_route53_zone_id
  name    = var.dns_name
  type    = "CNAME"
  records = list(var.maintenance_mode_enabled ? "${var.github_organization}.github.io" : aws_cloudfront_distribution.website_cdn[0].domain_name)
  ttl     = 60
}

resource "aws_route53_record" "dns_backdoor_record" {
  zone_id = var.aws_route53_zone_id
  name    = var.backdoor_dns_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.website_cdn[1].domain_name
    zone_id                = aws_cloudfront_distribution.website_cdn[1].hosted_zone_id
    evaluate_target_health = false
  }
}