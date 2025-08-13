package tfsec

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_security_group_rule"
  resource.change.after.cidr_blocks[_] == "0.0.0.0/0"
  ports := { p | p := resource.change.after.from_port .. resource.change.after.to_port }
  ports_overlap := 22 in ports or 3389 in ports
  ports_overlap
  msg := sprintf("%s exposes admin port to world", [resource.address])
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "azurerm_network_security_rule"
  resource.change.after.source_address_prefix == "*"  # Azure equivalent
  ports := { p | p := resource.change.after.destination_port_range }
  ports_overlap := "22" in ports or "3389" in ports
  ports_overlap
  msg := sprintf("%s exposes admin port to world", [resource.address])
}

