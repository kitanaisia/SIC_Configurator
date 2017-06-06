class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all
    p session[:member]
    p session[:music]

    @members= []
    @musics= []
    session[:member].each do |member|
      id = member[0]
      count = member[1]

      count.to_i.times do
        @members << Member.joins(:card).select("cards.*, members.*").find_by(number: id) 
      end
    end
    session[:music].each do |music|
      id = music[0]
      count = music[1]

      count.to_i.times do
        @musics << Music.joins(:card).select("cards.*, musics.*").find_by(number: id) 
      end
    end
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
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
    @deck = Deck.new(deck_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.fetch(:deck, {})
    end
end
