class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login

  validates :username,
    uniqueness: { case_sensitive: :false },
    length: { minimum: 4, maximum: 20 },
    format: { with: /\A[a-z0-9]+\z/, message: "ユーザー名は半角英数字です"}

  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
          where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
          where(conditions).first
      end
  end

  #登録時にemailを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end


end
