require 'fileutils'

desc "reload_database"
task :reload_db => :environment do
  ENV['RAILS_ENV'] = 'production'
  FileUtils.cp("#{RAILS_ROOT}/db/schema_good.rb", "#{RAILS_ROOT}/db/schema.rb") 
  ENV['VERSION'] = '0'
  Rake::Task['db:migrate'].invoke
  FileUtils.cp("#{RAILS_ROOT}/db/schema_good.rb", "#{RAILS_ROOT}/db/schema.rb") 
  ENV.delete 'VERSION'
  Rake::Task['db:migrate'].invoke
  FileUtils.cp("#{RAILS_ROOT}/db/schema_good.rb", "#{RAILS_ROOT}/db/schema.rb")
  Rake::Task['db:bootstrap'].invoke
end

desc "clean development applications by zhimin"
task :clean_app => :environment do
  sqls = ["delete from persist_objects  where session_id in (select id from persist_session where owner_id = 'zhimin')",
    "delete from persist_session where owner_id = 'zhimin'"]
  sqls.each { |stmt|
    puts stmt
    ActiveRecord::Base.connection.execute stmt
  }    
end

namespace "db" do
    desc "generate sql for migrations"
    task "migrate_sql" => :environment do
      MigrationSql.execute
    end
end
