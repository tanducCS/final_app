# == Schema Information
#
# Table name: photos
#
#  id                 :bigint           not null, primary key
#  title              :string           not null
#  description        :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null
#  image_url          :string           default("image.png"), not null
#  sharing_mode       :integer          default("public1"), not null
#  is_belong_to_album :boolean          default(FALSE)
#
class Photo < ApplicationRecord
  # Association
  enum :sharing_mode, [:public1, :private1]
  belongs_to :user

  has_many :photo_albums, dependent: :destroy
  has_many :albums, through: :photo_albums

  has_many :like_photos
  has_many :liked_by_users, through: :like_photos, source: :user




  # Validation
  validates :title, length: {maximum: 140}
  validates :description, length: {maximum: 300}
  validates :image_url, format: { with: /\.(png|jpg|gif)\z/i, message: "must be a valid image URL" }
  # image size validate
  validates :title, :sharing_mode, :description, :user_id, :image_url, presence: true

  mount_uploader :image_url, ImageUploader
end
