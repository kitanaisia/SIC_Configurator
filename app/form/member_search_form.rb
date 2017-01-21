class MemberSearchForm
  include ActiveModel::Model
  attr_accessor :id, :card_id, :name, :rarity

  def search
    member = Member.joins(:card).select("cards.*, members.*")
    member = member.where("name like ?", "%#{name}%") if name.present?
    member = member.where("rarity = " + rarity) if rarity.present?
    member
  end
end
