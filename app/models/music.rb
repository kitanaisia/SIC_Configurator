class Music < ApplicationRecord
  belongs_to :card, foreign_key: :card_id, primary_key: :card_id
end
