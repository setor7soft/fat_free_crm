# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'fat_free_crm/version'

Gem::Specification.new do |gem|
  gem.name = 'fat_free_crm'
  gem.authors = ['Michael Dvorkin', 'Ben Tillman', 'Nathan Broadbent', 'Stephen Kenworthy']
  gem.summary = 'Fat Free CRM'
  gem.description = 'An open source, Ruby on Rails customer relationship management platform'
  gem.homepage = 'http://fatfreecrm.com'
  gem.email = ['mike@fatfreecrm.com', 'nathan@fatfreecrm.com', 'warp@fatfreecrm.com', 'steveyken@gmail.com']
  gem.files = `git ls-files`.split("\n")
  gem.version = FatFreeCRM::VERSION::STRING
  gem.required_ruby_version = '>= 1.9'
  gem.license = 'MIT'

  gem.add_dependency 'rails',               '~> 4.0.0'
  gem.add_dependency 'prototype-rails'
  gem.add_dependency 'jquery-rails',        '~> 2.1.4' # pegs us to jQuery 1.8
  gem.add_dependency 'select2-rails'
  gem.add_dependency 'simple_form',         '~> 3.0.1'
  gem.add_dependency 'will_paginate',       '~> 3.0.2'
  gem.add_dependency 'paperclip'
  # Manually added paperclip gem dependency "cocaine" in order to fix load error: "no such file to load -- cocaine"
  gem.add_dependency 'cocaine'
  gem.add_dependency 'paper_trail',         '~> 3.0.3'
  gem.add_dependency 'authlogic'
  gem.add_dependency 'bcrypt', '~> 3.1.7'
  gem.add_dependency 'scrypt', '1.2.1'
  gem.add_dependency 'acts_as_commentable', '~> 3.0.1'
  gem.add_dependency 'acts-as-taggable-on', '~> 2.4.0'
  gem.add_dependency 'dynamic_form'
  gem.add_dependency 'haml'
  gem.add_dependency 'sass'
  gem.add_dependency 'acts_as_list',        '~> 0.1.4'
  gem.add_dependency 'ffaker',              '>= 1.22.0'
  gem.add_dependency 'cancan'
  gem.add_dependency 'font-awesome-rails'
  gem.add_dependency 'premailer'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'responds_to_parent',  '>= 1.1.0'
  gem.add_dependency 'rails3-jquery-autocomplete'
  gem.add_dependency 'psych', '~> 1'        if RUBY_VERSION.to_f < 2.0
  gem.add_dependency 'thor'

  # FatFreeCRM has released it's own versions of the following gems:
  #-----------------------------------------------------------------
  gem.add_dependency 'email_reply_parser_ffcrm'
end
