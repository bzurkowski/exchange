ActiveAdmin.register Term do
  decorate_with TermDecorator
  permit_params :subject_id, :instructor_id, :description, :starts_at, :ends_at

  index do
    id_column
    column :subject
    column :instructor
    column :description
    column :starts_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :subject
      row :instructor
      row :description
      row :starts_at
      row :ends_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :subject
      f.input :instructor
      f.input :description
      f.input :starts_at, as: :string, input_html: { class: "datetime_picker" }
      f.input :ends_at, as: :string, input_html: { class: "datetime_picker" }
    end
    f.actions
  end
end
