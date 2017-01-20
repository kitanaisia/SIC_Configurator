class Card < ApplicationRecord
  scope :get_by_name, -> (name) {
    where("name like ?", "%#{name}%")
  }
  scope :get_by_rarity, -> (rarity) {
    where("rarity like ?", "%#{rarity}%")
  }
end
