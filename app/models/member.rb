class Member < ApplicationRecord
  belongs_to :card, foreign_key: :number, primary_key: :number
  attr_accessor :count
end
