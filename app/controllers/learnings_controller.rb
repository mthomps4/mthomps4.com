class LearningsController < ApplicationController
  before_action :set_learning, only: %i[show edit update destroy]

  # GET /learnings or /learnings.json
  def index
    @learnings = Learning.all
  end

  # GET /learnings/1 or /learnings/1.json
  def show; end

  # GET /learnings/new
  def new
    @learning = Learning.new
  end

  # GET /learnings/1/edit
  def edit; end

  # POST /learnings or /learnings.json
  def create
    @learning = Learning.new(learning_params)

    respond_to do |format|
      if @learning.save
        format.html { redirect_to learning_url(@learning), notice: 'Learning was successfully created.' }
        format.json { render :show, status: :created, location: @learning }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @learning.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learnings/1 or /learnings/1.json
  def update
    respond_to do |format|
      if @learning.update(learning_params)
        format.html { redirect_to learning_url(@learning), notice: 'Learning was successfully updated.' }
        format.json { render :show, status: :ok, location: @learning }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @learning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learnings/1 or /learnings/1.json
  def destroy
    @learning.destroy

    respond_to do |format|
      format.html { redirect_to learnings_url, notice: 'Learning was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_learning
    @learning = Learning.find(params[:id])
    @rendered_markdown = LearningsHelper.render_markdown(@learning.markdown)
  end

  # Only allow a list of trusted parameters through.
  def learning_params
    params.require(:learning).permit(:title, :markdown, :published, :published_on)
  end
end
