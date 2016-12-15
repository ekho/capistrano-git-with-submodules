require "capistrano/scm/git"

class Capistrano::SCM::Git::WithSubmodules < Capistrano::SCM::Git

  def archive_to_release_path
    fail ':repo_tree currently not supported by GitWithSubmodules' if fetch(:repo_tree)


    return if backend.test(:test, '-e', release_path) && backend.test("ls -A #{release_path} | read linevar")

    _clone_repo

    backend.within_only release_path do
      git :submodule, 'update', '--init', '--recursive'
    end

    unless fetch(:git_keep_meta, false)
      verbose = Rake.application.options.trace ? 'v' : ''
      backend.execute("find #{release_path} -name '.git*' | xargs -I {} rm -rf#{verbose} '{}'")
    end
  end

  def _clone_repo
    git_version = backend.capture(:git, '--version').strip.match('^git version (\d+(?:\.\d+)+)$')

    if git_version.nil? || git_version[1] < '2.3.0'
      _clone_repo_with_old_git
    else
      _clone_repo_with_fresh_git
    end
  end

  def _clone_repo_with_fresh_git
    git :clone, '--reference', repo_path.to_s, '--dissociate', (fetch(:git_keep_meta, false) ? '' : '--depth=1'), '-b', fetch(:branch), repo_url, release_path
  end

  def _clone_repo_with_old_git
    git :clone, (fetch(:git_keep_meta, false) ? '' : '--depth=1'), '-b', fetch(:branch), "file://#{repo_path}", release_path
    backend.within_only release_path do
      git :remote, 'set-url', 'origin', repo_url
    end
  end
end


# shit hack to execute command only in specified directory
module SSHKit
  module Backend
    class Abstract
      def within_only(directory, &block)
        pwd = @pwd
        @pwd = []
        within directory, &block
      ensure
        @pwd = pwd
      end
    end
  end
end