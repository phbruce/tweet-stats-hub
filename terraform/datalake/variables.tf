variable "environment" {
  description = "Specify the deployment environment. This variable allows you to choose the environment where you want to deploy the infrastructure, which can be useful for managing multiple environments such as development, testing, and production"
  type        = string
  default     = "dev"
}
