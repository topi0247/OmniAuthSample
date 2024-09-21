class ReferenceUserAuthentications < ActiveRecord::Migration[7.2]
  def change
    add_reference :authentications, :user, foreign_key: true
  end
end
