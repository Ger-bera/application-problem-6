class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comment, dependent: :destroy

  has_many :do_follows, class_name: "Relationship", foreign_key: "followed_id",dependent: :destroy
  has_many :followers, through: :do_follows, source: :follower

  has_many :done_follows, class_name: "Relationship", foreign_key: "follower_id",dependent: :destroy
  has_many :followings, through: :done_follows, source: :followed

  def follow(user_id)
    done_follows.create(followed_id: user_id)
  end

  def unfollow(user_id)
    done_follows.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  attachment :profile_image
  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
