class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages

  def show_last_message
    unless defined? messages.last.content
      return "まだ投稿がありません"
    end
    if messages.last.content.empty?
      return "画像が投稿されています"
    else
      return messages.last.content
    end
  end
end
