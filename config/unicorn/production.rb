# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
# http://michaelvanrooijen.com/articles/2011/06/01-more-concurrency-on-a-single-heroku-dyno-with-the-new-celadon-cedar-stack/

# Production specific settings
#if RAILS_ENV == "production"
  # Help ensure your application will always spawn in the symlinked
  # "current" directory that Capistrano sets up.
  working_directory '/home/setor7/rails_apps/setor7_crm_staging/current'
  worker_processes 2
  #user "setor7"
  #pid "/home/unicorn/pids/unicorn.pid"
  pid "/home/setor7/rails_apps/setor7_crm_staging/current/unicorn/pids/unicorn.pid"

  # feel free to point this anywhere accessible on the filesystem
  shared_path = '/home/setor7/rails_apps/setor7_crm_staging/current'

  stderr_path '/home/setor7/rails_apps/setor7_crm_staging/current/log/unicorn.stderr.log'
  stdout_path '/home/setor7/rails_apps/setor7_crm_staging/current/log/unicorn.stdout.log'
#end
