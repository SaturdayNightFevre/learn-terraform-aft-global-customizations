data "aws_caller_identity" "current" {}

module "config_conformance_pack" {
  source  = "cloudposse/config/aws//modules/conformance-pack"
  version = "0.17.0"
  name             = "Operational-Best-Practices-for-HIPAA-Security"
  conformance_pack = "https://raw.githubusercontent.com/awslabs/aws-config-rules/master/aws-config-conformance-packs/Operational-Best-Practices-for-HIPAA-Security.yaml"
  parameter_overrides = {
    AccessKeysRotatedParamMaxAccessKeyAge = "45"
  }

  #s3_bucket_id                     = dependency.bucket.outputs.bucket_id
  #s3_bucket_arn                    = dependency.bucket.outputs.bucket_arn
  #global_resource_collector_region = local.region.locals.aws_region
  #tags = merge(local.common_tags.locals.default_tags, local.env_tags)
}
