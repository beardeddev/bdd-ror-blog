class Category < ActiveRecord::Base
  validates_presence_of :title, :keywords, :description, :status_id
  validates_uniqueness_of :title
  validates_length_of :title, :maximum => 64
  validates_length_of :keywords, :maximum => 128
  validates_length_of :description, :maximum => 128

  has_and_belongs_to_many :posts

  def to_param
    "#{self.id}-#{self.title.gsub(/\W+/, '_')}"
  end

  named_scope :active, :conditions => ["status_id = ? ", 1]
  named_scope :counted, :select => "categories.id, categories.title, count(posts.id)",
                        :joins => [:posts],
                        :order => "categories.title",
                        :group => "categories.id, categories.title",
                        :conditions => ["categories.status_id = ? AND posts.status_id = ?", 1, 1]
  named_scope :full, lambda { |category| { :include => [:posts], :conditions => ["id = ? AND status_id = ?", category, 1] } }

end
