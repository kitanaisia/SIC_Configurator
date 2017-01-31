class MusicSearchForm
  include ActiveModel::Model
  attr_accessor :id, :card_id, :select

  def search
    music = Music.joins(:card).select("cards.*, musics.*")
    music = music.where("score_common > 0") if select == "score_common"
    music
  end
end
