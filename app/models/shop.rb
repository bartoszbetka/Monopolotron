class Shop < ActiveRecord::Base

  has_many :comments
  has_and_belongs_to_many :users

  validates :shopname, :presence => true,
  :length => {:within => 3..50}

  validates :address, :presence => true,
  :length => {:within => 3..250},
  :uniqueness => true
  geocoded_by :address1
  after_validation :geocode, :if => lambda { |obj| obj.address_changed?}


  scope :sorted, lambda { order("name ASC")}
  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :search, lambda { |query|
    where(["name LIKE ?","%#{query}%"])
  }


  def address1
    [address, 'Wrocław', 'Polska'].compact.join(', ')
  end


end
