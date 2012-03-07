# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require './lib/version'

Gem::Specification.new do |s|
  s.name        = 'loquendo-wrapper'
  s.version     = Loquendo::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Patrick Ximenes']
  s.date        = Time.now.strftime("%Y-%m-%d")
  s.email       = ['hexaclamys@gmail.com']
  s.homepage    = 'https://github.com/hexams/loquendo-wrapper'
  s.summary     = %q{Ruby wrapper for Loquendo.}
  s.description = %q{Ruby wrapper for Loquendo using sample SaveFile command.}

  s.extra_rdoc_files = ['README']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
