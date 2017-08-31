class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :visits
  belongs_to :zone

  # Validations
  validates :email, uniqueness: true
  validates :name, :last_name, :role, presence: true
  validate :complete_preventor_data

  # Hooks
  before_validation :generate_password, on: :create
  after_create :create_admin_user, if: :role_admin?
  before_destroy :check_user_with_visits
  before_destroy :delete_admin_user, if: :role_admin?

  enum role: [:backoffice, :admin, :preventor], _prefix: true

  private

  # TODO: Eliminar el hardcodeo de password cuando se implemente el envio de mail
  def generate_password
    # generated_password = Devise.friendly_token.first(8)
    generated_password = '12345678'
    self.password = generated_password
    self.password_confirmation = generated_password
    # RegistrationMailer.welcome(user, generated_password).deliver
  end

  def check_user_with_visits
    return true if visits.count.zero?
    errors.add(:base, I18n.t('activerecord.errors.models.user.visits_assigned'))
    throw(:abort)
  end

  def create_admin_user
    AdminUser.create!(email: email, password: password, password_confirmation: password)
  end

  def delete_admin_user
    AdminUser.find_by(email: email).destroy
  end

  def complete_preventor_data
    return unless role_preventor?
    return if complete_preventor_data?
    errors.add(:latitude, :blank) if latitude.nil?
    errors.add(:longitude, :blank) if longitude.nil?
    errors.add(:zone, :blank) if zone.nil?
  end

  def complete_preventor_data?
    latitude && longitude && zone
  end
end
