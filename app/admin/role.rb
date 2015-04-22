ActiveAdmin.register Role do
  permit_params :name

  index do
    id_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
    end

    panel :users do
      table_for group.users do
        column :id
        column :username do |user|
          link_to user.username, admin_user_path(user)
        end
        column :student_number
        column :email
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
