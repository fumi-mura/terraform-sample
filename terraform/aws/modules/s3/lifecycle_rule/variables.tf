variable "rule_map" {
  type = map(object({
    id     = string
    status = string
    transition = list(object({
      days          = number
      storage_class = string
    }))
    expiration = list(object({
      days = number
    }))
  }))
}
