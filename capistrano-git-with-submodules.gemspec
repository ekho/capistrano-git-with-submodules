# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'capistrano-git-with-submodules/version'

Gem::Specification.new do |s|
  s.name          = "capistrano-git-with-submodules"
  s.version       = Capistrano::Git::With::Submodules::VERSION
  s.authors       = ["Boris Gorbylev"]
  s.email         = ["ekho@ekho.name"]
  s.homepage      = "https://github.com/ekho/capistrano-git-with-submodules"
  s.summary       = "Git submodules support for Capistrano 3.7+"
  s.description   = "Git submodules support for Capistrano 3.7+"
  s.license       = 'MIT'
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.files         = `git ls-files app lib`.split("\n")
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "capistrano", "~> 3.7"
end
