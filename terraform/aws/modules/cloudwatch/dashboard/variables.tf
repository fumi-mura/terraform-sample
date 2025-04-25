variable "dashboard_name" {
  type = string
}

variable "widgets" {
  type = any # jsonで型定義ができないためanyとしている
}
