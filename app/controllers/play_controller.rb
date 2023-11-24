# frozen_string_literal: true

class PlayController < ApplicationController
  def index; end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def fetch_tags
    tag_options = []

    if params[:search].present?
      tag_options = Tag.where('name ILIKE ?', "%#{params[:search]}%").where.not(id: params[:selectedIds])
    end

    respond_to do |format|
      format.html {}
      format.json { render json: tag_options }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('search-options', partial: 'tag_options', locals: { tag_options: })
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def update_tag_selections
    selected_ids = params[:selected] ||= ''
    parsed_ids = selected_ids.split(',').map(&:to_i)
    selected_tags = Tag.where(id: parsed_ids)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('selected-tags', partial: 'selected_tags', locals: { selected_tags: })
      end
    end
  end

  def submit_tags
    selected_tag_ids = params[:selected_tag_ids] ||= ''

    render turbo_stream: turbo_stream.replace('response', partial: 'response', locals: { selected_tag_ids: })
  end
end
