# frozen_string_literal: true

module Admin
  class ResumeController < AdminController
    def index
      @resumes = Resume.all.order(created_at: :desc).limit(10)
    end

    def new
      @resume = Resume.new
    end

    def create
      @resume = Resume.new(resume_params)
      if @resume.save
        redirect_to admin_resumes_path, notice: 'Resume was successfully uploaded.'
      else
        render :new, alert: 'Resume was not uploaded.'
      end
    end

    private

    def resume_params
      params.require(:resume).permit(:file)
    end
  end
end
