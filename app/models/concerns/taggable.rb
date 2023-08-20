module Taggable
  extend ActiveSupport::Concern

  def associate_tags(tag_names)
    tags.clear

    tag_names.each do |name|
      tag = Tag.find_or_create_by(name: name.strip)
      tags << tag unless tags.include?(tag)
    end
  end
end
