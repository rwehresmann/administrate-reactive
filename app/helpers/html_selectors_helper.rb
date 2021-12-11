# frozen_string_literal: true

module HtmlSelectorsHelper
  RESOURCES_TABLE = "resources-table"
  FLASHES = "flashes"

  def self.selectize(name, kind)
    raise "Invalid selector type" if ![:class, :id].include?(kind)

    symbol = kind == :class ? "." : "#"

    "#{symbol}name"
  end
end
