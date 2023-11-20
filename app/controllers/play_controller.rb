# frozen_string_literal: true

class PlayController < ApplicationController
  def index
    @tag_options = Tag.all.map { |t| [t.name, t.id] }
  end

  def fetch_tags
    @tags = Tag.all 
    @tag_options = @tags.map { |t| [t.name, t.id] }
  end
  
  def submit_tags 
    # TODO: 
  end 
end
