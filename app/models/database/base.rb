module Database
  class Base
    include Mongoid::Document

    field :user
    field :password

    belongs_to :app
  end
end
