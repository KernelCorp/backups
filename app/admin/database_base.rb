ActiveAdmin.register Database::Base do
  permit_params :_type, :user, :password

  form do |f|
    f.inputs do
      f.input :user
      f.input :password
      f.input :_type, as: :select, collection: [['Mongo','Database::Mongo'], ['Mysql','Database::Mysql']]
    end
    f.actions
  end
end
