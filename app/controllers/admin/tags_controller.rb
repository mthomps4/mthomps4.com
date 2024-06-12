# frozen_string_literal: true

module Admin
  class TagsController < AdminController
    def index
      search_params = params[:q] || {}
      @q = Tag.ransack(search_params)
      @tags = @q.result(distinct: true).page(params[:page]).per(25)
      @tag = Tag.new
    end

    def edit
      @tag = Tag.find(params[:id])
    end

    def create
      create_params = params.require(:tag).permit(:name)
      @tag = Tag.new(create_params)
      if @tag.save
        redirect_to admin_tags_path, notice: 'Saved!'
      else
        redirect_to admin_tags_path, alert: 'FAIL'
      end
    end

    def update
      @tag = Tag.find(params[:id])

      update_params = params.require(:tag).permit(:name)

      if @tag.update(update_params)
        redirect_to admin_tags_path, notice: 'Updated Successfully'
      else
        flash.now[:alert] = 'Failed to Update'
        render :edit
      end
    end

    def destroy; end
  end
end
