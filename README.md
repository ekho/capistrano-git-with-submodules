# capistrano-git-with-submodules [![Gem](https://img.shields.io/gem/v/capistrano-git-with-submodules.svg?maxAge=21600)](https://rubygems.org/gems/capistrano-git-with-submodules) [![Gem](https://img.shields.io/gem/dt/capistrano-git-with-submodules.svg?maxAge=21600)](https://rubygems.org/gems/capistrano-git-with-submodules)

Git submodule support for Capistrano 3.7+

For Capistrano 3.0-3.6 use old [capistrano-git-submodule-strategy](https://github.com/ekho/capistrano-git-submodule-strategy)

## Using

#### Gemfile
From rubygems.org (recommended)
```ruby
gem 'capistrano-git-with-submodules', '~> 2.0'
```

Latest revision from github
```ruby
gem 'capistrano-git-with-submodules', '~> 2.0', :github => 'ekho/capistrano-git-with-submodules'
```

#### Capfile
After
```ruby
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
```
add
```ruby
require "capistrano/scm/git-with-submodules"
install_plugin Capistrano::SCM::Git::WithSubmodules
```

> If you are upgrading from [`capistrano-git-submodule-strategy`](https://github.com/ekho/capistrano-git-submodule-strategy#using) you should remove its settings from your `Gemfile`, `Capfile` and `deploy.rb`.

## Contributing to capistrano-git-with-submodules

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2016 Boris Gorbylev. See LICENSE for further details.
