package tfsec

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_ebs_volume"
  not resource.change.after.encrypted
  msg := sprintf("%s has encryption disabled", [resource.address])
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "google_compute_disk"
  not resource.change.after.disk_encryption_key != null
  msg := sprintf("%s missing CMEK/CSE encryption key", [resource.address])
}

