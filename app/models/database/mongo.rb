module Database
  class Mongo < Database::Base
    include Mongoid::Document

    BACKUPS_PATH = "#{Rails.root}/public/system/backups/mongo"

    def do_backup(db_name)
      folder_name = generate_name(db_name)
      full_path = "#{BACKUPS_PATH}/#{folder_name}"
      `mongodump #{user_cmd} -d #{db_name} -o #{full_path}`
      folder_name
    end

    def rm_backup(folder_name)
      `rm -rf #{BACKUPS_PATH}/#{folder_name}`
    end

    private
    def user_cmd
      cmd = ''
      cmd += "-u #{user}"     unless user.blank?
      cmd += "-p #{password}" unless password.blank?
      cmd
    end

    def generate_name(db_name)
      "#{db_name}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
    end
  end
end
