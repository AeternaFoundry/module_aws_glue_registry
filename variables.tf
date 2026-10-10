variable "glue_registries" {
  description = <<EOT
Map of glue_registries, attributes below
Required:
    - registry_name
Optional:
    - description
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    registry_name = string
    description   = optional(string)
    region        = optional(string)
    tags          = optional(map(string))
    tags_all      = optional(map(string))
  }))
  validation {
    condition = alltrue([
      for k, v in var.glue_registries : (
        (length(v.registry_name) >= 1 && length(v.registry_name) <= 255) && (can(regex("[0-9A-Za-z_$#-]+$", v.registry_name)))
      )
    ])
    error_message = "all of: must be between 1 and 255 characters"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

