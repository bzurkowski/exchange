ActiveAdmin.register User do
  permit_params :username, :student_number, :email, group_ids: []
  actions :all, except: [:new, :create]

  index do
    id_column
    column :username
    column :student_number
    column :email
    actions
  end

  show do
    attributes_table do
      row :id
      row :username
      row :student_number
      row :email
      row :created_at
      row :updated_at
      row :confirmed_at
    end

    panel User.human_attribute_name(:groups) do
      table_for user.groups do
        column :id
        column :name
      end
    end

    panel User.human_attribute_name(:schedules) do
      table_for user.schedules do
        column :id do |schedule|
          link_to schedule.id, admin_schedule_path(schedule)
        end
        column Schedule.human_attribute_name(:created_at)
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :username
      f.input :student_number
      f.input :email
      f.input :groups
    end
    f.actions
  end
end
