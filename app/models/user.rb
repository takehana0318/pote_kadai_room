class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :icon, IconUploader

  validates :name, presence: true, on: :create
  validates :password, confirmation: true, if: -> { password.present? }
  validates :email, presence: true
  #validates :password, presence: true, confirmation: true
  #validates :password_confirmation, presence: true
end
