class Comment < ActiveRecord::Base
  validates_presence_of :user_name, :email, :unless => @current_user
  validates_presence_of :body
  validates_presence_of :captcha_text, :if => :validate_captcha

  def validate
    if self.validate_captcha && (self.captcha_text != self.session_captcha)
      errors.add(:captcha_text, "введнный код не совпадает с изображением")
    end
  end

  belongs_to :post

  named_scope :active, :conditions => ["status_id = ? ", 1]
  named_scope :ordered, :order => 'created_at DESC'

  attr_accessor :captcha_text, :session_captcha, :validate_captcha

end
