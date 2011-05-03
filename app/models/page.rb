require 'cgi'

class Page < ActiveRecord::Base

  def self.from_model(model)
    @page = Page.new(:title => model.title, :keywords => model.keywords, :description => model.description)
  end

  validates_presence_of :title, :keywords, :description, :url
  validates_uniqueness_of :url

  named_scope :active, :conditions => ["status_id = ? ", 1]

  def before_save
    self.title = CGI::unescape(self.title)
  end

end
