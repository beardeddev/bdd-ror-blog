class Post < ActiveRecord::Base

  validates_presence_of :title, :keywords, :description, :status_id
  validates_uniqueness_of :title
  validates_length_of :title, :maximum => 128
  validates_length_of :keywords, :maximum => 128
  validates_length_of :description, :maximum => 1024

  def before_save
    if(self.title_transliterated.blank?)
      self.title_transliterated = Russian.transliterate(self.title.gsub(/\W+/, '_'))
    end
  end

  has_and_belongs_to_many :categories, :conditions => ["categories.status_id = 1"]

  belongs_to :user
  has_many :comments

  named_scope :active, :conditions => ["status_id = ? ", 1]
  named_scope :ordered, :order => 'created_at DESC'
  named_scope :abbreviated, :select => 'posts.id, posts.title, posts.title_transliterated, posts.description,
                                          posts.hits, posts.created_at, posts.user_id, comments.comments_count AS comments_count',
                            :joins => ["LEFT OUTER JOIN (
                                                              SELECT COUNT(id) AS comments_count, post_id
                                                              FROM comments WHERE status_id = 1
                                                              GROUP BY post_id
                                                        )
                                              AS comments on posts.id = comments.post_id
                                      "],
                            :include => [:user, :categories],
                            :order => 'posts.created_at DESC',
                            :conditions => ["posts.status_id = 1"]

  named_scope :full,
              :include => [:user, :categories],
              :conditions => ["status_id = 1"]

  named_scope :archive, :select => "MONTH(created_at) AS month,
                                      YEAR(created_at) AS year, count(id) as count, created_at",
                        :order => 'created_at DESC',
                        :conditions => ["posts.status_id = 1"],
                        :group => "MONTH(created_at),  YEAR(created_at)"

  named_scope :archived, lambda {|month, year| {:conditions => ["EXTRACT(MONTH FROM created_at) = ?
                        AND EXTRACT(YEAR FROM created_at) = ?", month, year]} }

  named_scope :categorised, lambda { |category| { :select => "posts.id, posts.title, posts.title_transliterated,
                                                              posts.description, posts.hits, posts.created_at,
                                                              posts.user_id, comments.comments_count AS comments_count",
                                                  :joins => ["LEFT OUTER JOIN (
                                                                                SELECT COUNT(id) AS comments_count, post_id
                                                                                FROM comments WHERE status_id = 1
                                                                                GROUP BY post_id
                                                                              )
                                                              AS comments on posts.id = comments.post_id
                                                              INNER JOIN categories_posts ON posts.id = categories_posts.post_id
                                                            "],
                                                  :include => [:user, :categories],
                                                  :order => 'posts.created_at DESC',
                                                  :conditions => ["posts.status_id = ? AND category_id = ? ", 1, category] }}



  def to_param
    "#{self.id}-#{self.title_transliterated}"
  end

end
