class User < ActiveRecord::Base
  has_many :posts, foreign_key: "author_id", dependent: :destroy
end
