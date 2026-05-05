# frozen_string_literal: true

def mysql_repo_file(repo)
  "/etc/yum.repos.d/#{repo}.repo"
end
