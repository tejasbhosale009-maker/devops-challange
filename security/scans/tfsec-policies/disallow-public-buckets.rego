package tfsec

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"
  resource.change.after.acl == "public-read" or
  resource.change.after.acl == "public-read-write"
  msg := sprintf("%s allows public ACL", [resource.address])
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "google_storage_bucket"
  bindings := resource.change.after.iam_configuration.uniform_bucket_level_access == false
  bindings
  msg := sprintf("%s has uniform bucket-level access disabled (may allow public access)", [resource.address])
}

