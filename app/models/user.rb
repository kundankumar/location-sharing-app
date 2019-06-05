class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :places

  validates_presence_of :name, :username, :email
  validates_uniqueness_of :username, :email

  scope :all_except_me, ->(user) { where.not(id: user) }
end
