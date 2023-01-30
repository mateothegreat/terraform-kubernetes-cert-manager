variable "namespace" {
    type        = string
    default     = "default"
    description = "Namespace to deploy to"
}
variable "name" {
    type    = string
    default = "twingate"
}
variable "email" {
    type        = string
    description = "Email address for letsencrypt messages."
}
