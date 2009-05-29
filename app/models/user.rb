class User < ActiveRecord::Base

  has_many :characters_created, :class_name => "Character", :foreign_key => :created_by
  has_many :characters_modified, :class_name => "Character", :foreign_key => :modified_by
  has_many :events_created, :class_name => "Events", :foreign_key => :created_by
  has_many :events_modified, :class_name => "Events", :foreign_key => :modified_by
  has_many :locations_created, :class_name => "Locations", :foreign_key => :created_by
  has_many :locations_modified, :class_name => "Locations", :foreign_key => :modified_by
  has_many :experiences_created, :class_name => "Experiences", :foreign_key => :created_by
  has_many :experiences_modified, :class_name => "Experiences", :foreign_key => :modified_by
  has_many :userlimits
  has_many :universes, :through => :userlimits
  has_many :own_universes, :class_name => "Universe", :foreign_key => :creator_id
  belongs_to :current_universe, :class_name => "Universe", :foreign_key => :current_universe_id

  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  def to_label
    "#{self.username}"
  end


  private

  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end
