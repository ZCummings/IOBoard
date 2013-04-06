class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name_F, :name_L, :email, :password, :password_confirmation, :remember_me
  attr_accessible :status, :mode

  validates :mode_is_valid
  validates_presence_of :mode

  MODES = %w[available busy away]

  def mode_is_valid
    errors.add :mode, "must be a valid status: " + MODES.to_s unless
        MODES.include? self.mode
  end

  def mode= new_mode
    write_attribute :mode, new_mode
    write_attribute :mode_updated_at, Time.now
  end

  def status= new_status
    write_attribute :status, new_status
    write_attribute :status_updated_at, Time.now
  end

  before_validation do |user|
    if user.mode.nil?
      user.mode = "away"
    end
  end
end
