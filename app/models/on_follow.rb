# == Schema Information
#
# Table name: on_follows
#
#  id          :bigint           not null, primary key
#  follower_id :bigint
#  followee_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class OnFollow < ApplicationRecord
  belongs_to :follower, foreign_key: "follower_id", class_name: "User"
  belongs_to :followee, foreign_key: "followee_id", class_name: "User"
end
