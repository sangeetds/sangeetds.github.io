# -*- encoding: utf-8 -*-
# stub: octopress-codeblock 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "octopress-codeblock".freeze
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Brandon Mathis".freeze]
  s.date = "2015-01-05"
  s.description = "Write beautiful code snippets within any template.".freeze
  s.email = ["brandon@imathis.com".freeze]
  s.homepage = "https://github.com/octopress/codeblock".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Write beautiful code snippets within any template.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<octopress-code-highlighter>.freeze, ["~> 4.2"])
      s.add_development_dependency(%q<jekyll>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<clash>.freeze, [">= 0"])
    else
      s.add_dependency(%q<octopress-code-highlighter>.freeze, ["~> 4.2"])
      s.add_dependency(%q<jekyll>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<clash>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<octopress-code-highlighter>.freeze, ["~> 4.2"])
    s.add_dependency(%q<jekyll>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<clash>.freeze, [">= 0"])
  end
end
