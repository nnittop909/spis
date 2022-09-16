class User < ApplicationRecord
  include ActiveStoragePath
  include PgSearch::Model
  pg_search_scope( :search, 
                    against: [:first_name, :middle_name, :last_name, :fullname],
                    using: { tsearch: { prefix: true }} )
  attr_writer :login
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:admin, :employee, :developer]

  has_one_attached :avatar

  belongs_to :office

  validates :avatar, blob: { 
    content_type: ['image/jpg', 'image/jpeg', 'image/png'], 
    size_range: 0.1..3.megabytes 
  }

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username

  before_save :set_full_name
  before_validation :set_office
  after_save :set_default_avatar

  def to_s
    fullname
  end

  def name
    fullname
  end

  def reversed_fullname
    "#{last_name}, #{first_name}"
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def update_password_with_password(params, *options)
    current_password = params.delete(:current_password)

    result = if valid_password?(current_password)
               update_attributes(params, *options)
             else
               self.assign_attributes(params, *options)
               self.valid?
               self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
               false
             end

    clean_up_passwords
    result
  end

  private

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def set_full_name
    self.full_name = fullname
  end

  def set_office
    self.office_id = Office.last.id
  end

  def set_default_avatar
    if !avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), filename: 'default-avatar.png', content_type: 'image/png')
    end
  end
end
