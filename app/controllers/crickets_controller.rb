class CricketsController < ApplicationController
  before_action :set_cricket, only: [:show, :edit, :update, :destroy]

  # GET /crickets
  # GET /crickets.json
  def index
    @curscore=Leaderboard.find_by_user_id(current_user.id)
    @fupd=Leaderboard.find_by_user_id(current_user.id)
    @crickets = Leaderboard.order('cmax DESC')
    if @fupd.ccur == Cricket.count()
      @fupd.Cricket = 0
      @fupd.ccur =0
      @fupd.save
    end
  end

  # GET /crickets/1
  # GET /crickets/1.json
  def show
    @string=''
    @leaderbd=Leaderboard.find_by_user_id(current_user.id)
    @location='/crickets/'+(Integer(params[:id])+1).to_s
    @leaderbd.ccur=Integer(params[:id])
    if params[:id]=='1'
      @leaderbd.Cricket=0
      @leaderbd.cmax=@leaderbd.cmax > @leaderbd.Cricket ? @leaderbd.cmax : @leaderbd.Cricket

    end
    @leaderbd.save
    if @cricket
      if @cricket.mcq
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
      if(@string==@cricket.answer)
        @leaderbd.Cricket+=10
        @leaderbd.cmax=@leaderbd.cmax > @leaderbd.Cricket ? @leaderbd.cmax : @leaderbd.Cricket
        @leaderbd.save
      end
      if params[:A] or params[:B] or params[:C] or params[:D] or params[:mcmc] 
        if Integer(params[:id])==Cricket.count()
          redirect_to '/crickets/'
          # @leaderbd.Cricket=0
          # @leaderbd.ccur=0
          # @leaderbd.save
        else
          redirect_to @location
        end
      end
    else
      @leaderbd.Cricket=0
      @leaderbd.ccur=0
      @leaderbd.save
      redirect_to '/'
    end
  end

  # GET /crickets/new
  def new
    @cricket = Cricket.new
  end

  # GET /crickets/1/edit
  def edit
  end

  # POST /crickets
  # POST /crickets.json
  def create
    @cricket = Cricket.new(cricket_params)

    respond_to do |format|
      if @cricket.save
        format.html { redirect_to @cricket, notice: 'Cricket was successfully created.' }
        format.json { render :show, status: :created, location: @cricket }
      else
        format.html { render :new }
        format.json { render json: @cricket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crickets/1
  # PATCH/PUT /crickets/1.json
  def update
    respond_to do |format|
      if @cricket.update(cricket_params)
        format.html { redirect_to @cricket, notice: 'Cricket was successfully updated.' }
        format.json { render :show, status: :ok, location: @cricket }
      else
        format.html { render :edit }
        format.json { render json: @cricket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crickets/1
  # DELETE /crickets/1.json
  def destroy
    @cricket.destroy
    respond_to do |format|
      format.html { redirect_to crickets_url, notice: 'Cricket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cricket
      if Integer(params[:id]) <= Cricket.count
            @cricket = Cricket.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cricket_params
      params.require(:cricket).permit(:question, :option1, :option2, :option3, :option4, :answer)
    end
end
