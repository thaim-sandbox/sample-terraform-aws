terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = "thaim-sandbox"
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "repository_name" {
  description = "GitHub repository name"
  type        = string
}

resource "github_repository_environment" "test" {
  repository  = var.repository_name
  environment = "test"
}

resource "github_actions_environment_variable" "test_var" {
  repository    = var.repository_name
  environment   = github_repository_environment.test.environment
  variable_name = "TEST_VARIABLE"
  value         = "test_value"
}
