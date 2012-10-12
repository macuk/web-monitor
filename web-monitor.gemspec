# -*- encoding: utf-8 -*-
require File.expand_path('../lib/web-monitor/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Piotr Macuk"]
  gem.email         = ["piotr@macuk.pl"]
  gem.description   = %q{Website monitoring tool by response time and status}
  gem.summary       = %q{Website monitoring tool}
  gem.homepage      = "https://github.com/macuk/web-monitor"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "web-monitor"
  gem.require_paths = ["lib"]
  gem.version       = WebMonitor::VERSION
end
