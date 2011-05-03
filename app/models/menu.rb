class Menu < ActiveRecord::Base
  validates_presence_of :key, :name, :url
  validates_uniqueness_of :key, :name, :url
  validates_length_of :key, :maximum => 32
  validates_length_of :url, :name, :maximum => 128

  named_scope :active, :conditions => ["status_id = ? ", 1]
end
