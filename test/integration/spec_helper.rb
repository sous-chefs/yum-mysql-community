# frozen_string_literal: true

def mysql_repo_file(repo)
  "/etc/yum.repos.d/#{repo}.repo"
end

def mysql_platform_segment
  os.family == 'fedora' ? 'fc' : 'el'
end
