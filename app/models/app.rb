class App
  include Mongoid::Document

  field :name
  field :db_name
  field :keep_backups, type: Integer, default: 5

  belongs_to :database, class_name: 'Database::Base'
  embeds_many :backups

  validates_presence_of :database

  before_create :set_default_db_name

  delegate :rm_backup, to: :database

  def do_backup
    file_name = database.do_backup db_name
    backups.create file_name: file_name
    backups.first.destroy if backups.count > keep_backups
  end

  protected
    def set_default_db_name
      self.db_name = "#{name}_production" if db_name.blank?
    end
end
