class RemoveColumnToAnswers < ActiveRecord::Migration
  def change
  	remove_column :answers, :commenter, :string
  	rename_column :answers, :body, :response
  end
end
