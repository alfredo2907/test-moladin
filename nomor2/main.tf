module "codebuild" {
  source = "git::https://github.com/tmknom/terraform-aws-codebuild.git?ref=tags/1.2.0"
  name   = "example"

  artifact_bucket_arn = "${var.artifact_bucket_arn}"
  environment_type    = "LINUX_CONTAINER"
  compute_type        = "BUILD_GENERAL1_MEDIUM"
  image               = "aws/codebuild/docker:18.09.0"
  privileged_mode     = true
  buildspec           = "configuration/buildspec.yml"
  cache_type          = "S3"
  cache_location      = "${aws_s3_bucket.artifact.id}/codebuild"
  encryption_key      = ""
  build_timeout       = 10
  iam_path            = "/service-role/"
  description         = "This is example"

  enabled_ecr_access    = true
  ecr_access_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"

  tags = {
    Environment = "prod"
  }
}
