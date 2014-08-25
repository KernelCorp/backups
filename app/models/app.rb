class App
  include Mongoid::Document

  field :name
  field :db_name
  field :keep_backups, type: Integer, default: 5

  has_one :database, class_name: 'Database::Base'
  embeds_many :backups

  validates_presence_of :database

  delegate :rm_backup, to: :database

  def do_backup
    file_name = database.do_backup db_name
    backups.create file_name: file_name
  end
end