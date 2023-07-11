# == Schema Information
#
# Table name: albums
#
#  id           :bigint           not null, primary key
#  title        :string           not null
#  description  :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#  sharing_mode :integer          default(0), not null
#
#
=begin
== Schema Information

Table name: albums

 id           :bigint           not null, primary key
 title        :string           not null
 description  :string           not null
 created_at   :datetime         not null
 updated_at   :datetime         not null
 user_id      :bigint           not null
 sharing_mode :integer          default(0), not null

=end
class Album < ApplicationRecord
  belongs_to :user

  has_many :photo_albums, dependent: :destroy
  has_many :photos, through: :photo_albums

  # Validation
  validates :title, length: {maximum: 140}
  validates :description, length: {maximum: 300}
  # validates :sharing_mode, inclusion: [public,private]


  validates :title, :sharing_mode, :description, :user_id, presence: true

end
