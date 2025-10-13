variable "github_owner" {
  description = "GitHub user or organization that will own the repo."
  type        = string
}

variable "repo_name" {
  description = "Name of the repository to create."
  type        = string
  default     = "alillelund.github.io"
}

variable "visibility" {
  description = "Repository visibility – public or private."
  type        = string
  default     = "public"
}

