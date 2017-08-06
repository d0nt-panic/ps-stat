class AddAasmStateToTournSummaries < ActiveRecord::Migration[5.1]
  def change
    add_column :tourn_summaries, :aasm_state, :string, null: false
  end
end
