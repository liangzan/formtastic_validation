# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{formtastic_validation}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Wong Liang Zan"]
  s.date = %q{2010-08-31}
  s.description = %q{A formtastic extension that does client side validation}
  s.email = %q{zan@liangzan.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "javascripts/README.textile",
     "javascripts/build/formtastic_validation-0.1.0.min.js",
     "javascripts/lib/livevalidation-1.3.min.js",
     "javascripts/src/formtastic_validation.js",
     "lib/formtastic_validation.rb",
     "rails_generators/formtastic_validation/formtastic_validation_generator.rb",
     "rails_generators/formtastic_validation/templates/config/initializers/formtastic_validation.rb",
     "rails_generators/formtastic_validation/templates/public/javascripts/formtastic_validation-0.1.0.min.js",
     "rails_generators/formtastic_validation/templates/public/javascripts/livevalidation-1.3.min.js",
     "spec/formtastic_validation_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/liangzan/formtastic_validation}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Client side validation with formtastic}
  s.test_files = [
    "spec/formtastic_validation_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<validation_reflection>, ["= 0.3.8"])
      s.add_runtime_dependency(%q<formtastic>, ["= 1.0.0"])
      s.add_development_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_development_dependency(%q<rspec-rails>, ["= 1.3.2"])
      s.add_development_dependency(%q<rspec_tag_matchers>, ["= 1.0.0"])
      s.add_development_dependency(%q<nokogiri>, ["= 1.4.2"])
      s.add_development_dependency(%q<activesupport>, ["= 2.3.8"])
      s.add_development_dependency(%q<actionpack>, ["= 2.3.8"])
    else
      s.add_dependency(%q<validation_reflection>, ["= 0.3.8"])
      s.add_dependency(%q<formtastic>, ["= 1.0.0"])
      s.add_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_dependency(%q<rspec-rails>, ["= 1.3.2"])
      s.add_dependency(%q<rspec_tag_matchers>, ["= 1.0.0"])
      s.add_dependency(%q<nokogiri>, ["= 1.4.2"])
      s.add_dependency(%q<activesupport>, ["= 2.3.8"])
      s.add_dependency(%q<actionpack>, ["= 2.3.8"])
    end
  else
    s.add_dependency(%q<validation_reflection>, ["= 0.3.8"])
    s.add_dependency(%q<formtastic>, ["= 1.0.0"])
    s.add_dependency(%q<rspec>, ["= 1.3.0"])
    s.add_dependency(%q<rspec-rails>, ["= 1.3.2"])
    s.add_dependency(%q<rspec_tag_matchers>, ["= 1.0.0"])
    s.add_dependency(%q<nokogiri>, ["= 1.4.2"])
    s.add_dependency(%q<activesupport>, ["= 2.3.8"])
    s.add_dependency(%q<actionpack>, ["= 2.3.8"])
  end
end

