# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# Run system tests if the command is `rake test`
Rake::Task['test:system'].execute if ARGV.include?('test')
