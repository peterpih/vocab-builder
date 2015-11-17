class ResultListsController < ApplicationController
  before_action :set_result_list, only: [:show, :edit, :update, :destroy]

  # GET /result_lists
  # GET /result_lists.json
  def index
    @result_lists = ResultList.all
  end

  # GET /result_lists/1
  # GET /result_lists/1.json
  def show
  end

  # GET /result_lists/new
  def new
    @result_list = ResultList.new
  end

  # GET /result_lists/1/edit
  def edit
  end

  # POST /result_lists
  # POST /result_lists.json
  def create
    @result_list = ResultList.new(result_list_params)

    respond_to do |format|
      if @result_list.save
        format.html { redirect_to @result_list, notice: 'Result list was successfully created.' }
        format.json { render :show, status: :created, location: @result_list }
      else
        format.html { render :new }
        format.json { render json: @result_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /result_lists/1
  # PATCH/PUT /result_lists/1.json
  def update
    respond_to do |format|
      if @result_list.update(result_list_params)
        format.html { redirect_to @result_list, notice: 'Result list was successfully updated.' }
        format.json { render :show, status: :ok, location: @result_list }
      else
        format.html { render :edit }
        format.json { render json: @result_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /result_lists/1
  # DELETE /result_lists/1.json
  def destroy
    @result_list.destroy
    respond_to do |format|
      format.html { redirect_to result_lists_url, notice: 'Result list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def type_count
    ResultList.where(params[:type]).count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result_list
      @result_list = ResultList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_list_params
      params.require(:result_list).permit(:sessionid, :type, :value, :order)
    end
end
