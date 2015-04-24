class CreateOffersAndDemands < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :assignation, index: true
      t.integer    :status,      index: true, default: 0

      t.timestamps
    end

    add_foreign_key :offers, :assignations

    create_table :demands do |t|
      t.references :offer, index: true
      t.belongs_to :term,  index: true
    end

    add_foreign_key :demands, :offers
    add_foreign_key :demands, :terms
  end
end
