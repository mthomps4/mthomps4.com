# frozen_string_literal: true

module Admin
  class CollectionsController < AdminController
    def index
      search_params = params[:q] || {}
      @q = Collection.ransack(search_params)
      @collections = @q.result(distinct: true).page(params[:page]).per(25)
      @collection = Collection.new
    end

    def edit
      @collection = Collection.find(params[:id])
    end

    def create
      create_params = params.require(:collection).permit(:name)
      @collection = Collection.new(create_params)
      if @collection.save
        redirect_to admin_collections_path, notice: 'Saved!'
      else
        redirect_to admin_collections_path, alert: 'FAIL'
      end
    end

    def update
      @collection = Collection.find(params[:id])

      update_params = params.require(:collection).permit(:name)

      if @collection.update(update_params)
        redirect_to admin_collections_path, notice: 'Updated Successfully'
      else
        flash.now[:alert] = 'Failed to Update'
        render :edit
      end
    end

    def destroy; end
  end
end
