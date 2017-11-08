class HollywoodsController < ApplicationController
  before_action :set_hollywood, only: [:show, :edit, :update, :destroy]

  # GET /hollywoods
  # GET /hollywoods.json
  def index
    @curscore=Leaderboard.find_by_user_id(current_user.id)
    @hupd=Leaderboard.find_by_user_id(current_user.id)
    @hollywoods = Leaderboard.order('hmax DESC')
    if @hupd.hcur == Hollywood.count()
      @hupd.Hollywood = 0
      @hupd.hcur =0
      @hupd.save
    end
  end

  # GET /hollywoods/1
  # GET /hollywoods/1.json
  def show
    @string=''
    @leaderbd=Leaderboard.find_by_user_id(current_user.id)
    @location='/hollywoods/'+(Integer(params[:id])+1).to_s
    @leaderbd.hcur=Integer(params[:id])
    if params[:id]=='1'
      @leaderbd.Hollywood=0
      @leaderbd.hmax=@leaderbd.hmax > @leaderbd.Hollywood ? @leaderbd.hmax : @leaderbd.Hollywood

    end
    @leaderbd.save
    if @hollywood
      if @hollywood.mcq
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
      if(@string==@hollywood.answer)
        @leaderbd.Hollywood+=10
        @leaderbd.hmax=@leaderbd.hmax > @leaderbd.Hollywood ? @leaderbd.hmax : @leaderbd.Hollywood
        @leaderbd.save
      end
      if params[:A] or params[:B] or params[:C] or params[:D] or params[:mcmc] 
        if Integer(params[:id])==Hollywood.count()
          redirect_to '/hollywoods'
          # @leaderbd.Hollywood=0
          # @leaderbd.hcur=0
          # @leaderbd.save
        else
          redirect_to @location
        end
      end
    else
      @leaderbd.Hollywood=0
      @leaderbd.hcur=0
      @leaderbd.save
      redirect_to '/'
    end
  end

  # GET /hollywoods/new
  def new
    @hollywood = Hollywood.new
  end

  # GET /hollywoods/1/edit
  def edit
  end

  # POST /hollywoods
  # POST /hollywoods.json
  def create
    @hollywood = Hollywood.new(hollywood_params)

    respond_to do |format|
      if @hollywood.save
        format.html { redirect_to @hollywood, notice: 'Hollywood was successfully created.' }
        format.json { render :show, status: :created, location: @hollywood }
      else
        format.html { render :new }
        format.json { render json: @hollywood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hollywoods/1
  # PATCH/PUT /hollywoods/1.json
  def update
    respond_to do |format|
      if @hollywood.update(hollywood_params)
        format.html { redirect_to @hollywood, notice: 'Hollywood was successfully updated.' }
        format.json { render :show, status: :ok, location: @hollywood }
      else
        format.html { render :edit }
        format.json { render json: @hollywood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hollywoods/1
  # DELETE /hollywoods/1.json
  def destroy
    @hollywood.destroy
    respond_to do |format|
      format.html { redirect_to hollywoods_url, notice: 'Hollywood was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hollywood
      if Integer(params[:id]) <= Hollywood.count
            @hollywood = Hollywood.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hollywood_params
      params.require(:hollywood).permit(:question, :option1, :option2, :option3, :option4, :answer)
    end
end
