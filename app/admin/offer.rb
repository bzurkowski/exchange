ActiveAdmin.register Offer do
  decorate_with OfferDecorator
  permit_params :assignation_id, demands_attributes: [:term_id]

  index do
    id_column
    column :user
    column :term
    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :term
      row :status
      row :created_at
      row :updated_at
    end

    panel Offer.human_attribute_name(:demands) do
      table_for offer.demands do
        column Demand.human_attribute_name(:term) do |demand|
          demand.term.display_name
        end
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :assignation
      f.has_many :demands, allow_destroy: true, new_record: true do |demand|
        demand.inputs :term
      end
    end
    f.actions
  end
end
