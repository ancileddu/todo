# -*- encoding: utf-8 -*-
# stub: bootstrap_tokenfield_rails 0.12.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bootstrap_tokenfield_rails"
  s.version = "0.12.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Akash Devaraju"]
  s.date = "2015-09-25"
  s.description = "A gem for adding the tokenizing plugin, Bootstrap Tokenfield to the rails asset pipeline"
  s.email = ["akash.devaraju@icicletech.com"]
  s.homepage = "http://www.icicletech.com/open-source-software/bootstrap-tokenfield-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.2"
  s.summary = "A jQuery tagging / tokenizer input plugin for Twitter's Bootstrap"

  s.installed_by_version = "2.4.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
