package tfsec

deny[msg] {
  provider := input.configuration.provider_config[_]
  not contains(provider.version, "~>")
  msg := sprintf("Provider %s version not pinned (~> recommended)", [provider.name])
}

