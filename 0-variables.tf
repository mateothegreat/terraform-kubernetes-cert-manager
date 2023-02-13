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

variable "server" {
    type        = string
    default     = "https://acme-staging-v02.api.letsencrypt.org/directory"
    #    value       = "https://acme-v02.api.letsencrypt.org/directory"
    description = "Letsencrypt server to use."

}
