resource "github_repository" "maintenance-mode-repo" {
  name = var.github_repo_name
  description = "Maintenance mode repo for ${var.github_repo_name}"
  private = true
  auto_init = true
  default_branch = "master"
}

resource "github_repository_collaborator" "users_repos" {
  repository = github_repository.maintenance-mode-repo.name
  username = var.github_username
  permission = "admin"
  depends_on = [github_repository.maintenance-mode-repo]
}

resource "github_repository_file" "maintenance-mode-files" {
  repository = github_repository.maintenance-mode-repo.name
  for_each = {
    for key, value in fileset(path.root, "maintenance_mode_website/*.*"): value => value
  }
  // There is a limitation here, Terraform file function supports UTF-8 files,
  // so any images or other non text files can't be included in the folder.
  file = trimprefix(each.value, "maintenance_mode_website/")
  content = file(each.value)
  depends_on = [github_repository_collaborator.users_repos]
}
