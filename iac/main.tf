provider "github" {
  owner = "alillelund"
}

locals {
  gh_pages_branch = "gh-pages"
  name = "alillelund.github.io"
}


# --------------------------------------------------------------
# Create the repository
# --------------------------------------------------------------
resource "github_repository" "this" {
  name        = var.repo_name
  description = "My personal blog"

  visibility             = "public"
  delete_branch_on_merge = true
  auto_init              = true

  dynamic "pages" {
    for_each = false ? [""] : [] # on first run this should false, cannot reference branch that don't exists

    content {
      source {
        branch = local.gh_pages_branch
      }
    }
  }
}
# resource "github_repository" "site" {
#   name        = var.repo_name
#   description = "Static site built with Zola – managed by Terraform"
#   visibility  = var.visibility

#   # Enable issues, wiki etc. as you like:
#   has_issues   = true
#   has_wiki     = false
#   has_projects = false

#   # The default branch will be `main`. We’ll later push the built site to `gh-pages`.
#   auto_init    = true        # creates an initial README so we can push later
# }

# --------------------------------------------------------------
# Enable GitHub Pages (publishing from the gh‑pages branch)
# --------------------------------------------------------------
resource "github_branch_default" "this" {
  repository = github_repository.this.name
  branch     = "main"
}

resource "github_branch" "this" {
  repository = github_repository.this.name
  branch     = local.gh_pages_branch
  depends_on = [github_branch_default.this]
}
