# -*- encoding: utf-8 -*-
# stub: textext-rails 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "textext-rails"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jeff Pollard"]
  s.date = "2014-01-06"
  s.description = "Adds the jQuery TextExt plugin to the Rails 3.1 asset pipeline"
  s.email = ["jeff.pollard@gmail.com"]
  s.homepage = "https://github.com/Fluxx/textext-rails"
  s.rubyforge_project = "textext-rails"
  s.rubygems_version = "2.4.5.2"
  s.summary = "Adds the jQuery TextExt plugin to the Rails 3.1 asset pipeline"

  s.installed_by_version = "2.4.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
