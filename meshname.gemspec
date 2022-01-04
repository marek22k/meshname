Gem::Specification.new do |spec|
  spec.name        = "meshname"
  spec.version     = "1.0.0"
  spec.summary     = "Gem, which provides conversion and DNS resolution functions for the Meshname protocol."
  spec.description = "Gem, which provides conversion and DNS resolution functions for the Meshname protocol (see https://github.com/zhoreeq/meshname)"
  spec.authors     = ["Marek Kuethe"]
  spec.email       = "m.k@mk16.de"
  spec.files       = ["lib/meshname.rb"]
  spec.homepage    = "https://github.com/marek22k/meshname"
  spec.license     = "GPL-3.0-or-later"
  spec.add_dependency "base32", ">= 0.3.4"
end
