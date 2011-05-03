class Tag < ActiveRecord::Base
  validates_presence_of :title, :status_id, :keywords, :description
  validates_uniqueness_of :title
  validates_length_of :title, :maximum => 256
  validates_length_of :keywords, :maximum => 128
  validates_length_of :description, :maximum => 256
end
