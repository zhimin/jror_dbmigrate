require 'find'

# Reference: http://blog.jayfields.com/2006/11/rails-generate-sql-from-migrations.html

class SqlWriter

  def self.write(path, string)
    File.open(path, 'a') { |file| file.puts string }
  end
 
end

class MigrationSql
  class << self
    def execute
      connection = ActiveRecord::Base.connection
      old_method = connection.class.instance_method(:execute)

      define_execute(connection) { |*args| SqlWriter.write(@sql_write_path, args) }
   
      root = RAILS_ROOT + "/db/migrate"
      output_dir = root + "/../migration_sql"  
      FileUtils.rm_r "#{RAILS_ROOT}/db/migration_sql", :force => true        
      Dir.mkdir output_dir unless File.exists? output_dir
=begin
      output_reverse_dir = root + "/../migration_sql/reverse"
      Dir.mkdir output_reverse_dir unless File.exists? output_reverse_dir
=end      
      Find.find(root) do |path|
        unless path == root
          require path
          file = File.basename(path, ".rb")          
           write_sql(connection, output_dir, file, :up)
#          write_sql(connection, output_reverse_dir, file, :down)
        end
      end
   
      define_execute(connection) { |*args| old_method.bind(self).call(*args) }
    end
   
    def write_sql(connection, output_dir, file, direction = nil)      
      connection.instance_variable_set :@sql_write_path, output_dir + "/" + file  + "_#{direction}.sql"
      file.gsub(/^\d\d\d_/,'').camelize.constantize.send direction
    end
   
    def define_execute(connection, &block)
      connection.class.send :define_method, :execute, &block
    end
  end
end