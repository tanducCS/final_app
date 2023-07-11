# == Schema Information
#
# Table name: photo_albums
#
#  id         :bigint           not null, primary key
#  photo_id   :bigint
#  album_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PhotoAlbum < ApplicationRecord
  belongs_to :photo
  belongs_to :album


end
