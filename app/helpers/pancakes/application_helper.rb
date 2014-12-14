module Pancakes
  module ApplicationHelper

    def boolean_glyphicon(boolean_value)
      falsey_list = ["NO", nil, false]
      glyphicon_id = boolean_value.in?(falsey_list) ? 'glyphicon-remove' : 'glyphicon-ok'
      content_tag(:span, nil, class: "glyphicon #{glyphicon_id}")
    end

  end
end
