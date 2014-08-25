module Database
  class Base
    include Mongoid::Document

    field :user
    field :password
    field :_type

    has_many :app

    validates_presence_of :_type
  end
end
