resource "aws_route53_record" "servers" {
  for_each = local.broker_endpoints

  name     = "kafka-${var.client}-${var.env}-${regex("[^.]+", each.value)}.${data.aws_route53_zone.vector_cloud_com.name}"
  provider = aws.vector_eks_euw1
  records  = [each.key]
  ttl      = "60"
  type     = "CNAME"
  zone_id  = data.aws_route53_zone.vector_cloud_com.zone_id
}