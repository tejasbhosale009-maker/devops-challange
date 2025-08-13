package tfsec

required_tags = ["Environment", "Owner", "CostCenter"]

deny[msg] {
  resource := input.resource_changes[_]
  resource.change.after.tags != null
  tag := required_tags[_]
  not resource.change.after.tags[tag]
  msg := sprintf("%s missing required tag: %s", [resource.address, tag])
}

