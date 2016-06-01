class AddStatusToEmailDigest < ActiveRecord::Migration
  def change
    add_column :email_digests, :status, :string
  end
end
