// Variables

# BUCKET NAMES
variable "bucket_names" {
  type = map(string)
  default = {
    "diffs" = "EXAMPLE-rep-diffs"

    "old" = "EXAMPLE-rep-mirror-copy"

    "new" = "EXAMPLE-rep-new-mirror"
  }
}

# TAGS
variable "tags" {
  type = map(string)
  default = {
    "Co-Owner" = "EXAMPLE"
    "Owner"    = "EXAMPLE"
    "Team"     = "EXAMPLE"
  }
}