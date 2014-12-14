require 'ostruct'

module Pancakes
  class Record < OpenStruct
    include ActiveModel::Conversion
  end
end
