# intentionally throws an error since this attribute already exists!
class ChangeArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :created_at, :datetime
  end
end
