Gem::Specification.new do |s|
  s.name        = "capistrano-git-with-submodules"
  s.version     = '1.2.0'
  s.authors     = ["Boris Gorbylev"]
  s.email       = "ekho@ekho.name"
  s.homepage    = "https://github.com/ekho/capistrano-git-with-submodules"
  s.summary     = "Git submodules support for Capistrano 3.7+"
  s.description = "Git submodules support for Capistrano 3.7+"
  s.required_rubygems_version = ">= 1.3.6"
  s.files = ["lib/capistrano/scm/git-with-submodules.rb"]
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.license = 'MIT'
  s.add_dependency "capistrano", "~> 3.7"
end
