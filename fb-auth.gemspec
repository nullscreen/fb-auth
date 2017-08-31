# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fb/auth/version'

Gem::Specification.new do |spec|
  spec.name          = 'fb-auth'
  spec.version       = Fb::Auth::VERSION
  spec.authors       = ['Aaron Dao', 'Claudio Baccigalupo']
  spec.email         = ['aaron.dao@fullscreen.com', 'claudio@fullscreen.net']

  spec.summary       = %q{Ruby client to authenticate a Facebook user.}
  spec.description   = %q{Fb::Auth provides methods to obtain an access token to
    manage pages of a Facebook user.}
  spec.homepage      = 'https://github.com/Fullscreen/fb-auth'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fb-support', '~> 1.0.0.alpha2'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.9.9'
  spec.add_development_dependency 'coveralls'
end
