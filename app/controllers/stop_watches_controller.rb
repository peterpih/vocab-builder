class StopWatchesController < ApplicationController
  before_action :set_stop_watch, only: [:show, :edit, :update, :destroy]

  # GET /stop_watches
  # GET /stop_watches.json
  def index
    @stop_watches = StopWatch.all
  end

  # GET /stop_watches/1
  # GET /stop_watches/1.json
  def show
  end

  # GET /stop_watches/new
  def new
    @stop_watch = StopWatch.new
  end

  # GET /stop_watches/1/edit
  def edit
  end

  # POST /stop_watches
  # POST /stop_watches.json
  def create
    @stop_watch = StopWatch.new(stop_watch_params)

    respond_to do |format|
      if @stop_watch.save
        format.html { redirect_to @stop_watch, notice: 'Stop watch was successfully created.' }
        format.json { render :show, status: :created, location: @stop_watch }
      else
        format.html { render :new }
        format.json { render json: @stop_watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stop_watches/1
  # PATCH/PUT /stop_watches/1.json
  def update
    respond_to do |format|
      if @stop_watch.update(stop_watch_params)
        format.html { redirect_to @stop_watch, notice: 'Stop watch was successfully updated.' }
        format.json { render :show, status: :ok, location: @stop_watch }
      else
        format.html { render :edit }
        format.json { render json: @stop_watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stop_watches/1
  # DELETE /stop_watches/1.json
  def destroy
    @stop_watch.destroy
    respond_to do |format|
      format.html { redirect_to stop_watches_url, notice: 'Stop watch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop_watch
      @stop_watch = StopWatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stop_watch_params
      params.require(:stop_watch).permit(:start, :stop)
    end
end
