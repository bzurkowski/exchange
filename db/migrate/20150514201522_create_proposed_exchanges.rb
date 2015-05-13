class CreateProposedExchanges < ActiveRecord::Migration
  def change
    create_table :proposed_exchanges do |t|
      t.references :subject,           index: true,             null: false
      t.integer    :demands_hash,      index: true,             null: false, limit: 8

      t.timestamps
    end
    add_foreign_key :proposed_exchanges, :subjects

    create_table :proposed_exchange_demands do |t|
      t.references :proposed_exchange, index: true,             null: false
      t.references :demand,            index: true,             null: false
      t.integer    :status,            index: true, default: 0, null: false
    end
    add_foreign_key :proposed_exchange_demands, :proposed_exchanges
    add_foreign_key :proposed_exchange_demands, :demands
  end
end
