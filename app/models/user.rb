class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :roles
  has_many :posts

  def admin?
    self.roles.exists?(1)
  end

end
