class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    # 検索用のセレクトボックスに表示する、名前一覧
    @name_list = Member.joins(:card).select("cards.name").order("cards.name").distinct
    @rarity_list = Member.select(:rarity).order(:rarity).distinct

    # 検索の実行
    @search_form
    if params[:search] == nil
      @search_form = MemberSearchForm.new
    else
      attr = params.require(:search).permit(:name, :rarity) # strong parameters
      @search_form = MemberSearchForm.new(attr)
    end
    @members = @search_form.search
    @members = @members.order("cards.number").page(params[:page])
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def buy
    session[:member] ||= Hash.new(0)
    session[:member][params[:member_number]] = params[:number].to_i
    pp session[:member]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.joins(:card).select("cards.*, members.*").find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.fetch(:member, {})
    end
end
