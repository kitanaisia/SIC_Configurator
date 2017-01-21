class Member < ApplicationRecord
  belongs_to :card, foreign_key: :card_id, primary_key: :card_id

  scope :get_by_name, -> (name) {
    where("name like ?", "%#{name}%")
  }
  scope :get_by_rarity, -> (rarity) {
    where("rarity like ?", "%#{rarity}%")
  }
end
