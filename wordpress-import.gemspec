# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name        = "wordpress-import"
  s.summary     = "Import WordPress XML dumps into typo."
  s.description = "This gem imports a WordPress XML dump"
  s.version     = "0.5.0"
  s.date        = "2013-02-22"

  s.authors     = ['David Middleton','Marc Remolt']
  s.email       = 'david.middleton@gmail.com'
  s.homepage    = 'https://github.com/peon374/wordpress-import'

  s.add_dependency 'bundler', '~> 1.0'
  s.add_dependency 'nokogiri', '~> 1.5.0'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'database_cleaner'

  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
end
