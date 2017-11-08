class BollywoodsController < ApplicationController
  before_action :set_bollywood, only: [:show, :edit, :update, :destroy]

  # GET /bollywoods
  # GET /bollywoods.json
  def index
    @curscore=Leaderboard.find_by_user_id(current_user.id)
    @bupd=Leaderboard.find_by_user_id(current_user.id)
    @bollywoods = Leaderboard.order('bmax DESC')
    if @bupd.bcur == Bollywood.count()
      @bupd.Bollywood = 0
      @bupd.bcur =0
      @bupd.save
    end
  end

  # GET /bollywoods/1
  # GET /bollywoods/1.json
  def show
    @string=''
    @leaderbd=Leaderboard.find_by_user_id(current_user.id)
    @location='/bollywoods/'+(Integer(params[:id])+1).to_s
    @leaderbd.bcur=Integer(params[:id])
    if params[:id]=='1'
      @leaderbd.Bollywood=0
      @leaderbd.bmax=@leaderbd.bmax > @leaderbd.Bollywood ? @leaderbd.bmax : @leaderbd.Bollywood
    end
    @leaderbd.save
    if @bollywood
      if @bollywood.mcq
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
      if(@string==@bollywood.answer)
        @leaderbd.Bollywood+=10
        @leaderbd.bmax=@leaderbd.bmax > @leaderbd.Bollywood ? @leaderbd.bmax : @leaderbd.Bollywood
        @leaderbd.save
      end
      if params[:A] or params[:B] or params[:C] or params[:D] or params[:mcmc] 
        if Integer(params[:id])==Bollywood.count()
          redirect_to '/bollywoods'
          # @leaderbd.Bollywood=0
          # @leaderbd.bcur=0
          # @leaderbd.save
        else
          redirect_to @location
        end
      end
    else
      @leaderbd.Bollywood=0
      @leaderbd.bcur=0
      @leaderbd.save
      redirect_to '/'
    end
  end

  # GET /bollywoods/new
  def new
    @bollywood = Bollywood.new
  end

  # GET /bollywoods/1/edit
  def edit
  end

  # POST /bollywoods
  # POST /bollywoods.json
  def create
    @bollywood = Bollywood.new(bollywood_params)

    respond_to do |format|
      if @bollywood.save
        format.html { redirect_to @bollywood, notice: 'Bollywood was successfully created.' }
        format.json { render :show, status: :created, location: @bollywood }
      else
        format.html { render :new }
        format.json { render json: @bollywood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bollywoods/1
  # PATCH/PUT /bollywoods/1.json
  def update
    respond_to do |format|
      if @bollywood.update(bollywood_params)
        format.html { redirect_to @bollywood, notice: 'Bollywood was successfully updated.' }
        format.json { render :show, status: :ok, location: @bollywood }
      else
        format.html { render :edit }
        format.json { render json: @bollywood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bollywoods/1
  # DELETE /bollywoods/1.json
  def destroy
    @bollywood.destroy
    respond_to do |format|
      format.html { redirect_to bollywoods_url, notice: 'Bollywood was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bollywood
      if Integer(params[:id]) <= Bollywood.count
            @bollywood = Bollywood.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bollywood_params
      params.require(:bollywood).permit(:question, :option1, :option2, :option3, :option4, :answer)
    end
end
