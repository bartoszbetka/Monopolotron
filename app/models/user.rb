class User < ActiveRecord::Base


  has_many :comments
  has_and_belongs_to_many :shops

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i



  validates :name, :presence => true,
  :length => {:within => 3..30}

  validates :email, :presence => true,
  :length => {:maximum => 100},
  :format => EMAIL_REGEX,
  :confirmation => true,
  :uniqueness => true

  validates :password_digest, :length => {:minimum => 6},
  :confirmation => true,
  :presence => true

  validates :terms_of_service, :acceptance => true
  validates :accept_age, :acceptance => true

  scope :sorted, lambda { order("name ASC")}
  scope :privilege, lambda { where(:privilege => true) }


  private


end
