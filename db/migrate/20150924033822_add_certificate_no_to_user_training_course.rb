class AddCertificateNoToUserTrainingCourse < ActiveRecord::Migration
  def change
    add_column :user_training_courses, :certificate_no, :string
  end
end
