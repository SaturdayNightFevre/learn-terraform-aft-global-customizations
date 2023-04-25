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

module "config" {
  source  = "cloudposse/config/aws"
  version = "0.17.0"
  create_sns_topic = true
  create_iam_role  = true
  #  managed_rules                    = dependency.conformance_pack.outputs.rules.
  force_destroy                    = true
  s3_bucket_id                     = module.config_storage.bucket_id
  s3_bucket_arn                    = module.config_storage.bucket_arn
  global_resource_collector_region = "eu-west-2"
  central_resource_collector_account = "605188504569"
  #tags                             = merge(local.common_tags.locals.default_tags, local.env_tags)
}
