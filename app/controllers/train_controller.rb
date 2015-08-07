class TrainController < BaseController
  def notice_index
  	@training_courses = TrainingCourse.all
  end

  def notice_info
  end

  def work_info
  end
end
