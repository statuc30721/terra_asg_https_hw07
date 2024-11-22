data "aws_route53_zone" "main" {
    name    = "devlab405.click" # Domain name 
    private_zone = false
}

# Add DNS A record to route 53 database.

resource "aws_route53_record" "app1" {
    zone_id = data.aws_route53_zone.main.zone_id
  name = "app1.devlab405.click"
  type = "A"

  alias {
    name = aws_lb.ASG01-LB01.dns_name
    zone_id = aws_lb.ASG01-LB01.zone_id
    evaluate_target_health = true
    
  }
}