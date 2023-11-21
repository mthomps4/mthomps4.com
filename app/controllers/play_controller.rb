# frozen_string_literal: true

class PlayController < ApplicationController
  def index; end

  def fetch_tags
    tags = Tag.where('name ILIKE ?', "%#{params[:search]}%")
    tag_options = map_tags(tags)

    respond_to do |format|
      format.html {}
      format.json { render json: tag_options }
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search-options', partial: 'tag_options', locals: { tag_options: })
      end
    end
  end

  def submit_tags
    # TODO:
  end

  private

  def map_tags(tags)
    tags.map { |t| { name: t.name, id: t.id } }
  end
end
