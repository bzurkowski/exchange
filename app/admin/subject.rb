ActiveAdmin.register Subject do
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

    panel Subject.human_attribute_name(:terms) do
      table_for subject.terms.decorate do
        column :id do |term|
          link_to term.id, admin_term_path(term)
        end
        column Term.human_attribute_name(:instructor), :instructor
        column Term.human_attribute_name(:starts_at), :starts_at
        column Term.human_attribute_name(:ends_at), :ends_at
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
