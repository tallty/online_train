class TrainingCoursesController < BaseController
  def index
    @all_training_courses = TrainingCourse.all.page(params[:page]).per(15).keyword(params[:keyword])
  	@search_training_courses = TrainingCourse.where(category: params[:category]).page(params[:page]).per(15).keyword(params[:keyword])
  end

  def show
  	@training_course = TrainingCourse.find(params[:id])
    #读取通过审核的报名对象
    @user_training_courses = UserTrainingCourse.where(training_course_id: @training_course.id, state: true)
  	if current_user.present?
  	  @present_user_training_course = UserTrainingCourse.where(user_id: current_user.id, training_course_id: @training_course.id).first
  	end
  end

  def list
  end

  def print
    @training_course = TrainingCourse.find(params[:id])
     respond_to do |format|
      format.html
      format.pdf do
        render :pdf => @training_course.name.to_s + "报名表",
               :template => "training_courses/print.pdf.erb",
               :layout => 'pdf.html.erb'
      end
    end
  end
end
