package tfsec

# Keywords to scan for
secret_keywords = [
  "password",
  "secret",
  "token",
  "apikey",
  "private_key",
  "access_key"
]

deny[msg] {
  # Check variables or resource attributes
  resource := input.resource_changes[_]
  field := resource.change.after[_]
  is_string(field)
  lower_field_name := lower(key(resource.change.after, field))
  
  # Match if name contains secret keyword
  some kw
  kw := secret_keywords[_]
  contains(lower_field_name, kw)

  # Direct value set (not referencing var./data.)
  not startswith(field, "var.")
  not startswith(field, "data.")

  msg := sprintf("Hardcoded secret found in %s attribute '%s'", [resource.address, lower_field_name])
}

# Helper: get key name for a given value in an object
key(obj, value) = k {
  k := keys(obj)[i]
  obj[k] == value
}

