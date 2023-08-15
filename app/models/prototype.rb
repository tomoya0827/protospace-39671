class Prototype < ApplicationRecord
  belongs_to :user  #アソシエーションの設定
  has_one_attached :image  #画像ファイルのアソシエーションの設定
  has_many :comments, dependent: :destroy

  validates :title, presence: true  #バリデーションの設定
  validates :catch_copy, presence: true  #バリデーションの設定
  validates :concept, presence: true  #バリデーションの設定
  validates :image, presence: true  #バリデーションの設定

end
