require "capistrano/plugin"

class Capistrano::SCM::Git::WithSubmodules < Capistrano::Plugin

  def register_hooks
    after 'git:create_release', 'git:submodules:create_release'
  end

  def define_tasks
    namespace :git do
      namespace :submodules do

        desc "Adds configured submodules recursively to release"
        # It does so by connecting the bare repo and the work tree using environment variables
        # The reset creates a temporary index, but does not change the working directory
        # The temporary index is removed after everything is done
        task create_release: :'git:update' do
          temp_index_file_path = release_path.join("TEMP_INDEX_#{fetch(:release_timestamp)}")

          on release_roles :all do
            with fetch(:git_environmental_variables).merge(
                'GIT_DIR' => repo_path.to_s,
                'GIT_WORK_TREE' => release_path.to_s,
                'GIT_INDEX_FILE' => temp_index_file_path.to_s
            ) do
              within release_path do
                verbose = Rake.application.options.trace ? 'v' : ''
                quiet = Rake.application.options.trace ? '' : '--quiet'

                execute :git, :reset, '--mixed', quiet, fetch(:branch), '--'
                execute :git, :submodule, 'update', '--init', '--checkout', '--recursive', quiet
                execute :find, release_path, "-name '.git'", "|",  "xargs -I {} rm -rf#{verbose} '{}'"
                execute :rm, "-f#{verbose}", temp_index_file_path.to_s
              end if test :test, '-f', release_path.join('.gitmodules')
            end
          end
        end
      end
    end
  end
end
