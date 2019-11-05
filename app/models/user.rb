class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :messages

  def self.search(keyword)
    return nil if keyword.strip.empty?
    User.where('name LIKE(?)', "%#{keyword}%")
  end
end
