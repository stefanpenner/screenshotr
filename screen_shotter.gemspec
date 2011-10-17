# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'screen_shotter/version'

Gem::Specification.new do |s|
  s.name        = 'screen_shotter'
  s.version     = ScreenShotter::VERSION
  s.authors     = ['Stefan Penner']
  s.email       = ['stefan.penner@gmail.com']
  s.homepage    = ''
  s.summary     = %q{test test test}
  s.description = %q{test test test test}

  s.rubyforge_project = 'screen_shotter'

  s.files         = `git ls-files`.split('\n')
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables   = ['screen_shotter']
  s.default_executable = 'screen_shotter'
  #s.require_paths = %w[lib lib/skullstatus]

  # specify any dependencies here; for example:
  s.add_development_dependency 'rake'
  s.add_runtime_dependency 'sinatra'
  s.add_runtime_dependency 'rest-client'
  s.add_runtime_dependency 'fog'
  s.add_runtime_dependency 'jruby-openssl'
end
