class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  before_save :populate_tags

  def populate_tags
    self.tags ||= {}
    count = self.tags.count
    make_new = 3
    make_new = make_new - count if count
    (0..make_new).each do |i|
      self.tags[Faker::Lorem.word] = 1
    end
    self.tags.each do |key, value|
      self.tags[key] = Random.new.rand(0...999)
    end
  end
end
