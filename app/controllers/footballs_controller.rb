class FootballsController < ApplicationController
  before_action :set_football, only: [:show, :edit, :update, :destroy]

  # GET /footballs
  # GET /footballs.json
  def index
    @curscore=Leaderboard.find_by_user_id(current_user.id)
    @fupd=Leaderboard.find_by_user_id(current_user.id)
    @footballs = Leaderboard.order('fmax DESC')
    if @fupd.fcur == Football.count()
      @fupd.Football = 0
      @fupd.fcur =0
      @fupd.save
    end
  end

  # GET /footballs/1
  # GET /footballs/1.json
  def show
    @string=''
    @leaderbd=Leaderboard.find_by_user_id(current_user.id)
    @location='/footballs/'+(Integer(params[:id])+1).to_s
    @leaderbd.fcur=Integer(params[:id])
    if params[:id]=='1'
      @leaderbd.Football=0
      @leaderbd.fmax=@leaderbd.fmax > @leaderbd.Football ? @leaderbd.fmax : @leaderbd.Football

    end
    @leaderbd.save
    if @football
      if @football.mcq
        if(params[:A])  
          @string=@string+'A'
        end
        if(params[:B])
          @string=@string+'B'
        end
        if(params[:C])
          @string=@string+'C'
        end
        if(params[:D])
          @string=@string+'D'
        end
      else
        @string=params[:mcmc]
      end
      if(@string==@football.answer)
        @leaderbd.Football+=10
        @leaderbd.fmax=@leaderbd.fmax > @leaderbd.Football ? @leaderbd.fmax : @leaderbd.Football
        @leaderbd.save
      end
      if params[:A] or params[:B] or params[:C] or params[:D] or params[:mcmc] 
        if Integer(params[:id])==Football.count()
          redirect_to '/footballs/'
          # @leaderbd.Football=0
          # @leaderbd.fcur=0
          # @leaderbd.save
        else
          redirect_to @location
        end
      end
    else
      @leaderbd.Football=0
      @leaderbd.fcur=0
      @leaderbd.save
      redirect_to '/'
    end
  end

  # GET /footballs/new
  def new
    @football = Football.new
  end

  # GET /footballs/1/edit
  def edit
  end

  # POST /footballs
  # POST /footballs.json
  def create
    @football = Football.new(football_params)

    respond_to do |format|
      if @football.save
        format.html { redirect_to @football, notice: 'Football was successfully created.' }
        format.json { render :show, status: :created, location: @football }
      else
        format.html { render :new }
        format.json { render json: @football.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /footballs/1
  # PATCH/PUT /footballs/1.json
  def update
    respond_to do |format|
      if @football.update(football_params)
        format.html { redirect_to @football, notice: 'Football was successfully updated.' }
        format.json { render :show, status: :ok, location: @football }
      else
        format.html { render :edit }
        format.json { render json: @football.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /footballs/1
  # DELETE /footballs/1.json
  def destroy
    @football.destroy
    respond_to do |format|
      format.html { redirect_to footballs_url, notice: 'Football was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_football
      if Integer(params[:id]) <= Football.count
            @football = Football.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def football_params
      params.require(:football).permit(:question, :option1, :option2, :option3, :option4, :answer)
    end
end
