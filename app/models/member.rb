class Member < ApplicationRecord
  belongs_to :card, foreign_key: :card_id, primary_key: :card_id
  attr_accessor :count
end
