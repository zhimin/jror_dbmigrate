require 'fileutils'

task :bootstrap => :environment do
    RAILS_ENV = ENV['RAILS_ENV']
    RAILS_ENV = "development" if RAILS_ENV.nil? || RAILS_ENV.empty?
    puts "Bootstraping env: #{RAILS_ENV}"
    bootstrap_dir = File.join(RAILS_ROOT, "db", "bootstrap")
    Dir.chdir(bootstrap_dir)
    files = Dir.glob("*.sql")
    ActiveRecord::Base.transaction do
        files.each do |sql_file|
            if ["iter", "staging", "production"].include?(ENV['RAILS_ENV'])
                if sql_file == "interface_specifications.sql" then
                    puts "[Info] Skip interface_specfications table for iter, staging, production"
                    next
                end
                if sql_file == "edais_integration_services.sql" then
                    puts "[Info] Skip edais_integration_services table for iter, staging, production"
                    next
                end
            end
            puts "[Debug] Loading #{sql_file}"
            file_content = File.read(File.join(bootstrap_dir, sql_file))
            file_content.each_line do |stmt|
                next if stmt.nil? || stmt.empty? || stmt.strip.empty?
                ActiveRecord::Base.connection.execute stmt
            end
        end

        # customised for local environment
        if ["developmemnt", "cruisecontrol", "developer"].include?(RAILS_ENV)
         ActiveRecord::Base.connection.execute("update interest_descriptions set active = 0")
         ActiveRecord::Base.connection.execute("update interest_descriptions set active = 1 where id = 14") # Futur public
         ActiveRecord::Base.connection.execute("update interest_descriptions set active = 1 where id = 2")  # Koala
         ActiveRecord::Base.connection.execute("update interest_descriptions set active = 1 where id = 59") # Strategic Port Land
         ActiveRecord::Base.connection.execute("update interest_descriptions set active = 1 where id = 1") # South East Queensland Regional Plan
        end
    end
end
