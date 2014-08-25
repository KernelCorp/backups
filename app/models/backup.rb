class Backup
  include Mongoid::Document
  include Mongoid::Timestamps

  field :file_name
  embedded_in :app

  before_destroy do
    app.rm_backup file_name
  end
end
