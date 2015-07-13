class TrainController < ApplicationController
  def notice_index
  end

  def notice_info
  end

  def apply_index
  	@training_courses = TrainingCourse.all.page(params[:page]).per(1)
  end

  def apply_info
  end
end
