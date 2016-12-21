require "capistrano/scm/git"

class Capistrano::SCM::Git::WithSubmodules < Capistrano::SCM::Git
  alias_method :origin_archive_to_release_path, :archive_to_release_path if method_defined?(:archive_to_release_path)

  def archive_to_release_path
    origin_archive_to_release_path

    return unless backend.test(:test, '-e', release_path) && backend.test("ls -A #{release_path} | read linevar")

    submodules_to_release_path

    unless fetch(:git_keep_meta, false)
      verbose = Rake.application.options.trace ? 'v' : ''
      backend.execute("find #{release_path} -name '.git*' | xargs -I {} rm -rf#{verbose} '{}'")
    end
  end

  ##
  # Adds configured submodules recursively to release
  # It does so by connecting the bare repo and the work tree using environment variables
  # The reset creates a temporary index, but does not change the working directory
  # The temporary index is removed after everything is done
  def submodules_to_release_path
    temp_index_file_path = release_path.join("INDEX_#{fetch(:release_timestamp)}")
    backend.within "../releases/#{fetch(:release_timestamp)}" do
      backend.with(
          'GIT_DIR' => repo_path.to_s,
          'GIT_WORK_TREE' => release_path.to_s,
          'GIT_INDEX_FILE' => temp_index_file_path.to_s
      ) do
        git :reset, '--mixed', fetch(:branch)
        git :submodule, 'update', '--init', '--depth', 1, '--checkout', '--recursive'
        verbose = Rake.application.options.trace ? 'v' : ''
        backend.execute :rm, "-f#{verbose}", temp_index_file_path.to_s
      end
    end
  end
end
