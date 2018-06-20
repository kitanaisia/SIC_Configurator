class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy, :battle]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all

    @members= []
    @musics= []

    begin
      session[:member].each do |member|
        id = member[0]
        count = member[1]

        count.to_i.times do
          @members << Member.joins(:card).select("cards.*, members.*").find_by(number: id) 
        end
      end
    rescue
      # do nothing
    end

    begin
      session[:music].each do |music|
        id = music[0]
        count = music[1]

        count.to_i.times do
          @musics << Music.joins(:card).select("cards.*, musics.*").find_by(number: id) 
        end
      end
    rescue
      # do nothing
    end
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
  end

  # GET /decks/1/battle
  def battle
    # === セッション情報の初期化 ===
    # 待機中メンバー = スタートメンバー
    session[:waiting] = [@members.first.id]

    # 手札
    session[:deck] = @members[1..-1].shuffle.map {|member| member.id }
    session[:hand] = session[:deck].pop(4)
    
    # セットリスト
    session[:setlist_closed] = @musics.shuffle.map {|music| music.id }
    session[:setlist_open] = session[:setlist_closed].pop(2)

    # ライブ中
    session[:live] = []

    self.rendering
  end

  # デッキからカード1ドロー
  def draw
    session[:hand] <<  session[:deck].pop if session[:deck].length > 0
    self.rendering
  end

  # 登場
  def enter
    session[:waiting] << session[:hand].delete_at(params[:index].to_i)
    self.rendering
  end

  # 登場
  def enter_from_top
    session[:waiting] << session[:deck].pop if session[:deck].length > 0
    self.rendering
  end

  # 手札をデッキの一番上に置く
  def to_top
    session[:deck] << session[:hand].delete_at(params[:index].to_i)
    self.rendering
  end

  # 手札をデッキの一番下に置く
  def to_bottom
    # ボトムすなわちデッキ配列の先頭に追加
    session[:deck].unshift(session[:hand].delete_at(params[:index].to_i))
    self.rendering
  end

  # セットリストオープン 
  def setlist_open
    session[:setlist_open] << session[:setlist_closed].pop if session[:setlist_closed].length > 0
    self.rendering
  end

  # セットリストオープン 
  def back
    session[:hand] << session[:waiting].delete_at(params[:index].to_i)
    self.rendering
  end

  # ライブする
  def live
    music = ""
    members = []

    music = session[:setlist_open].delete_at(params[:music].to_i)
    params[:member][:index].sort {|x, y| y.to_i <=> x.to_i }.each do |index|
      members << session[:waiting].delete_at(index.to_i)
    end
    session[:setlist_open] << session[:setlist_closed].pop if session[:setlist_closed].length > 0

    live = [music, members]
    session[:live] << live

    self.rendering
  end

  # GET /decks/new
  def new
    @deck = Deck.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    memberlist_id = Memberlist.maximum(:memberlist_id)
    if memberlist_id.nil?
        memberlist_id = 1
    else
      memberlist_id += 1
    end

    setlist_id = Setlist.maximum(:setlist_id)
    if setlist_id.nil?
        setlist_id = 1
    else
      setlist_id += 1
    end

    # memberlist, setlistの作成
    session[:member].each do |member|
      id = member[0]
      count = member[1]
      Memberlist.new(memberlist_id: memberlist_id, number: id, count: count).save
    end
    session[:music].each do |music|
      id = music[0]
      count = music[1]
      Setlist.new(setlist_id: setlist_id, number: id, count: count).save
    end

    # デッキの作成
    @deck = Deck.new(name: params[:name], memberlist_id: memberlist_id, setlist_id: setlist_id)

    # セッション情報の削除
    session[:member].clear
    session[:music].clear

    respond_to do |format|
      if @deck.save
        format.html { redirect_to @deck, notice: 'Deck was successfully created.' }
        format.json { render :show, status: :created, location: @deck }
      else
        format.html { render :new }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
        format.json { render :show, status: :ok, location: @deck }
      else
        format.html { render :edit }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to decks_url, notice: 'Deck was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_member
    session[:member][params[:member_number]] -= 1
    pp session[:member]
  end

  def remove_music
    session[:music][params[:music_number]] -= 1
    pp session[:music]
  end

  def rendering
    # === セッション情報を基に画面に表示するカード情報を取得 ===
    @waiting = session[:waiting].map {|id| Member.joins(:card).select("cards.*, members.*").find(id) }
    @hands = session[:hand].map {|id| Member.joins(:card).select("cards.*, members.*").find(id) }
    @setlist_open = session[:setlist_open].map {|id| Music.joins(:card).select("cards.*, musics.*").find(id) }
    @live = session[:live].map {|elem| 
      [Music.joins(:card).select("cards.*, musics.*").find(elem[0]), elem[1].map {|id| 
        Member.joins(:card).select("cards.*, members.*").find(id) 
      }]
    }
    @live ||= [] 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
      memberlist = Memberlist.where(memberlist_id: @deck.memberlist_id)

      @members = []
      @musics = []
      memberlist.each do |member|
        member.count.to_i.times do
          @members << Member.joins(:card).select("cards.*, members.*").find_by(number: member.number)
        end
      end

      setlist = Setlist.where(setlist_id: @deck.setlist_id)
      setlist.each do |music|
        music.count.to_i.times do
          @musics << Music.joins(:card).select("cards.*, musics.*").find_by(number: music.number)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.fetch(:deck, {})
    end
end
