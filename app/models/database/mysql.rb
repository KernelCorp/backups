module Database
  class Mysql < Database::Base
    include Mongoid::Document

    BACKUPS_PATH = "#{Rails.root}/public/system/backups/mysql"

    def do_backup(db_name)
      `mkdir #{BACKUPS_PATH}` unless File.directory?(BACKUPS_PATH)
      folder_name = generate_name(db_name)
      full_path = "#{BACKUPS_PATH}/#{folder_name}"
      `mysqldump #{user_cmd} #{db_name} > #{full_path}`
      folder_name
    end

    def rm_backup(folder_name)
      `rm #{BACKUPS_PATH}/#{folder_name}`
    end

    private
    def generate_name(db_name)
      "#{db_name}_#{Time.now.strftime('%Y%m%d%H%M%S')}.sql"
    end
  end
end
