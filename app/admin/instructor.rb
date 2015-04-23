ActiveAdmin.register Instructor do
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

    panel Instructor.human_attribute_name(:terms) do
      table_for instructor.terms.decorate do
        column :id
        column Term.human_attribute_name(:subject), :subject
        column Term.human_attribute_name(:starts_at), :starts_at
        column Term.human_attribute_name(:ends_at), :ends_at
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :terms
    end
    f.actions
  end
end
