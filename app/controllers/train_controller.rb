class TrainController < BaseController
  def notice_index
  	@training_courses = TrainingCourse.all.page(params[:page]).per(15)
  end

  def notice_info
  end

  def work_info
  end
end
