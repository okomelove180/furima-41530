class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid (must use zenkaku)' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid (must use zenkaku)' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'is invalid (must use katakana)' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'is invalid (must use katakana)' }
  validates :birthday, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password,
            format: { with: VALID_PASSWORD_REGEX,
                      message: 'is invalid (must contain both alphabet and numbers / must be half-width alphanumeric)' }
end
