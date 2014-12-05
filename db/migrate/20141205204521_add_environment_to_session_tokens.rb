class AddEnvironmentToSessionTokens < ActiveRecord::Migration
  def change
    add_column :session_tokens, :environment, :string
  end
end
