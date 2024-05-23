resource "aws_route53_zone" "zona_primare" {
  name = "besfort.com"
}

resource "aws_route53_health_check" "health_check_primar" {
  fqdn              = "primare.besfort.com"
  type              = "HTTP"
  port              = 80
  resource_path     = "/health"
  failure_threshold = 3
}

resource "aws_route53_health_check" "health_check_secondar" {
  fqdn              = "secondar.besfort.com"
  type              = "HTTP"
  port              = 80
  resource_path     = "/health"
  failure_threshold = 3
}

resource "aws_route53_record" "primare" {
  zone_id = "Z0153575JS1JIZ49UNY8"
  name    = "www.besfort.com"
  type    = "A"
  ttl     = 60

 set_identifier = "primary"
  failover_routing_policy {
    type = "PRIMARY"
  }

  records = ["50.19.113.211"]
  health_check_id = "c5cfdf1e-fb4e-4ff9-892b-dc8548187ea3"
}

resource "aws_route53_record" "secondare" {
  zone_id = "Z0153575JS1JIZ49UNY8"
  name    = "www.besfort2.com"
  type    = "A"
  ttl     = 60

  set_identifier = "secondary"
  failover_routing_policy {
    type = "SECONDARY"
  }

  records = ["50.19.113.211"]
  health_check_id = "862669e1-7b2b-4c24-a93d-d15e6fb99cf8"
}