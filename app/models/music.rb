class Music < ApplicationRecord
  belongs_to :card, foreign_key: :number, primary_key: :number
end
