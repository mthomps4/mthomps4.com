# frozen_string_literal: true

BetterHtml.config = BetterHtml::Config.new(YAML.load(File.read(Rails.root.join('.better-html.yml'))))
