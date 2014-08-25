ActiveAdmin.register App do

  permit_params :name, :db_name, :database_id, :keep_backups

  member_action :do_backup, method: :post do
    app = App.find params[:id]
    app.do_backup
    redirect_to :back
  end

  index do
    selectable_column
    column :name
    column :db_name
    actions defaults: true do |inquire|
      link_to 'Backup', do_backup_admin_app_path(inquire), method: :post
    end
  end

  show do |app|
    attributes_table do
      row :id
      row :name
      row :db_name
      row :database
    end
    panel 'Backups' do
      table_for app.backups do
        column :id
        column :created_at
      end
    end
  end

end
