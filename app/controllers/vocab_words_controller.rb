class VocabWordsController < ApplicationController
  before_action :set_vocab_word, only: [:show, :edit, :update, :destroy]

  # GET /vocab_words
  # GET /vocab_words.json
  def index
    logger.debug "-----index-----"
    @vocab_words = VocabWord.all
  end

  # GET /vocab_words/1
  # GET /vocab_words/1.json
  def show
    logger.debug "-----show----- " + @vocab_word.word
    #@vocab_word = VocabWord.first
    logger.debug "-----id----- " + @vocab_word.id.to_s
  end

  # GET /vocab_words/new
  def new
    @vocab_word = VocabWord.new
  end

  def next
    logger.debug "-----next-----"
    url = request.original_url
    logger.debug "=====" + url.to_s + "====="
    u = URI.parse(url)
    logger.debug "-----scheme " + u.scheme + "-----"
    logger.debug "-----host " + u.host + "-----"
    logger.debug "-----path " + u.path + "-----"
    logger.debug "-----query " + u.query.to_s + "-----"
    domain = u.host
    if (domain == "localhost")
      logger.debug "-----localhost-----"
      domain = domain + ":3000"
    end
    logger.debug "-----domain " + domain + "-----"
    if u
      p = CGI.parse(u.query)
      logger.debug "-----u " + u.query.to_s + "-----"
      logger.debug "-----p " + p.to_s + "-----"

      # p is now {"id"=>["4"], "empid"=>["6"]
      id = p['id'].first
    else
      id = 0
    end
    logger.debug "-----id: " + id.to_s + "-----"
    #redirect_to @new_url
    #
    @vocab_word = VocabWord.where("id > ?", id).first
    logger.debug "-----return: " + @vocab_word.to_s
    if (! @vocab_word)
      @vocab_word = VocabWord.where("id > ?", 0).first  # circle back for now
    end
    next_id = @vocab_word.id
    logger.debug "-----next id: " + next_id.to_s + "-----"
    @next_url = u.scheme + "://" + domain + u.path + "?id=" + next_id.to_s
    logger.debug "-----next_url: " + @next_url + "-----"
    #@vocab_word = VocabWord.find(id.next)
    #logger.debug @vocab_word.id.to_s
    #@vocab_word = VocabWord.where("id > ?", id).first
    #logger.debug "-----back----- " + @vocab_word.id.to_s
    #@vocab_word = VocabWord.first

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
      logger.debug "-----set_vocab_word----- " + params[:id].to_s
      @vocab_word = VocabWord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vocab_word_params
      params.require(:vocab_word).permit(:id, :word, :lesson)
    end
end
