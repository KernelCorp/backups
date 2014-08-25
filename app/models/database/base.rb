module Database
  class Base
    include Mongoid::Document

    field :user
    field :password
    field :_type

    has_many :app

    validates_presence_of :_type

    protected
    def user_cmd
      cmd = ''
      cmd += "-u#{user}"     unless user.blank?
      cmd += "-p#{password}" unless password.blank?
      cmd
    end
  end
end
