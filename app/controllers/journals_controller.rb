class JournalsController < BaseController
	before_action :set_journal, only: [:edit, :update]

	def index
		@training_course = TrainingCourse.find(params[:training_course_id])
		@journals = Journal.where(training_course_id: @training_course.id, user_id: current_user.id).page(params[:page]).per(20)
	end

	def new
		@journal = Journal.new
	end

	def create
		@journal = Journal.new(journal_params)
		@journal.user_id = current_user.id
		@user_training_course_ids = UserTrainingCourse.where(user_id: current_user.id).pluck(:training_course_id)
		if @journal.save
			return redirect_to journal_user_index_path
		else
			return render action: :new
		end
	end

	def edit
	end

	def update
		if @journal.update(journal_params)
			return redirect_to journal_user_index_path
		else
			return render action: :edit
		end
	end

	private
	def journal_params
		params.require(:journal).permit(:user_id, :training_course_id, :content, :title, :add_date)
	end

	def set_journal
		@journal = Journal.find(params[:id])
	end
end