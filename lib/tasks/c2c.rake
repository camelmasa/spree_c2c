require 'ffaker'

namespace :spree_c2c do
  desc 'Loads c2c data'
  task :load do
    c2c_path = File.join(File.dirname(__FILE__), '..', '..', 'db', 'c2c')

    Rake::Task['db:load_dir'].reenable
    Rake::Task['db:load_dir'].invoke(c2c_path)
  end
end
