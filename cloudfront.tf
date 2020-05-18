resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${aws_s3_bucket.website_bucket.bucket} access identity"
}

resource "aws_cloudfront_distribution" "website_cdn" {
  count   = 2 # one for the actual cloudfront and one is for the backdoor
  enabled = true
  price_class  = "PriceClass_200"
  http_version = "http2"
  default_root_object = "index.html"

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    domain_name = aws_s3_bucket.website_bucket.bucket_domain_name
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      headers = []
      cookies {
        forward = "none"
      }
    }

    min_ttl          = 0
    default_ttl      = 86400 // 1 day
    max_ttl          = 31536000 // 1 year
    target_origin_id = "origin-bucket-${aws_s3_bucket.website_bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = count.index == 0 ? var.acm_certificate_arn : var.acm_certificate_arn_backdoor
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  aliases = list(count.index == 0 ? var.dns_name : var.backdoor_dns_name)
}
