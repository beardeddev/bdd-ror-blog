class Role < ActiveRecord::Base
  validates_presence_of :title
  validates_length_of :title, :maximum => 64

  has_and_belongs_to_many :users

end
