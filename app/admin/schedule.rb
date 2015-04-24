ActiveAdmin.register Schedule do
  permit_params :user_id, term_ids: []
  actions :all

  index do
    id_column
    column :user
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :created_at
      row :updated_at
    end

    panel Schedule.human_attribute_name(:terms) do
      table_for schedule.terms.decorate do
        column :id do |term|
          link_to term.id, admin_term_path(term)
        end
        column Term.human_attribute_name(:instructor), :instructor
        column Term.human_attribute_name(:subject), :subject
        column Term.human_attribute_name(:starts_at), :starts_at
        column Term.human_attribute_name(:ends_at), :ends_at
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :user
      f.input :terms
    end
    f.actions
  end
end
