resource "aws_cloudfront_distribution" "test-cf" {
    enabled = true
    origin {
      domain_name = aws_lb.test-lb.dns_name      
      origin_id = aws_lb.test-lb.dns_name
      
      custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy  = "http-only"
        origin_ssl_protocols = [ "TLSv1.2" ]
        
      }
    }

    default_cache_behavior {
      viewer_protocol_policy = "redirect-to-https"
      allowed_methods = ["GET","HEAD","OPTIONS","PUT","POST","PATCH","DELETE"]
      cached_methods = [ "GET","HEAD","OPTIONS" ]
      target_origin_id = aws_lb.test-lb.dns_name
      
      forwarded_values {
        headers = [ "all" ]
        query_string = false
        cookies {
          forward = "none"
        }

      }
     
      min_ttl = 0
      default_ttl = 300
      max_ttl = 500
      compress = true
    }

    restrictions  {
      geo_restriction  {
        restriction_type = "whitelist"
        locations = ["US", "CA", "GB", "DE","IN"]
      }
    }

    tags = {
      "Name" = "test-cf"
    }
    

    viewer_certificate {
      cloudfront_default_certificate = true
    }
  
}