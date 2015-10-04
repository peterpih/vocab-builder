class VocabWordsController < ApplicationController
  before_action :set_vocab_word, only: [:show, :edit, :update, :destroy]

  # GET /vocab_words
  # GET /vocab_words.json
  def index
    @vocab_words = VocabWord.all
  end

  # GET /vocab_words/1
  # GET /vocab_words/1.json
  def show
  end

  # GET /vocab_words/new
  def new
    @vocab_word = VocabWord.new
  end

  # GET /vocab_words/1/edit
  def edit
  end

  # POST /vocab_words
  # POST /vocab_words.json
  def create
    @vocab_word = VocabWord.new(vocab_word_params)

    respond_to do |format|
      if @vocab_word.save
        format.html { redirect_to @vocab_word, notice: 'Vocab word was successfully created.' }
        format.json { render :show, status: :created, location: @vocab_word }
      else
        format.html { render :new }
        format.json { render json: @vocab_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vocab_words/1
  # PATCH/PUT /vocab_words/1.json
  def update
    respond_to do |format|
      if @vocab_word.update(vocab_word_params)
        format.html { redirect_to @vocab_word, notice: 'Vocab word was successfully updated.' }
        format.json { render :show, status: :ok, location: @vocab_word }
      else
        format.html { render :edit }
        format.json { render json: @vocab_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vocab_words/1
  # DELETE /vocab_words/1.json
  def destroy
    @vocab_word.destroy
    respond_to do |format|
      format.html { redirect_to vocab_words_url, notice: 'Vocab word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vocab_word
      @vocab_word = VocabWord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vocab_word_params
      params.require(:vocab_word).permit(:word, :lesson)
    end
end
