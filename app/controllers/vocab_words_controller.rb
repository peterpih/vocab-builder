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
    logger.debug "-----new-----"
    @vocab_word = VocabWord.new
  end

 # GET /vocab_words/1/edit
  def edit
  end

  def quiz_init
    logger.debug "-----quiz_init-----"
    first = ResultList.first

    index_list = ResultList.create({sessionid: session.id.to_s, descrip: 'index', seq: 0})
    correct_list = ResultList.create({sessionid: session.id.to_s, descrip: 'correct', i_value: 0})
    miss_list = ResultList.create({sessionid: session.id.to_s, descrip: 'miss', i_value: 0})
    result_list = ResultList.create({sessionid: session.id.to_s, descrip: 'starttime', i_value: Time.now.seconds_since_midnight})

    redirect_to :quiz_next
  end

  def quiz_correct
    logger.debug "-----quiz_correct-----"
    index_list = ResultList.where("sessionid=? and descrip='index'", session.id.to_s).first
    @result_list = ResultList.where("sessionid=? and descrip='word' and seq=?", session.id.to_s, index_list.seq).first
    index_list.update_attribute(:seq, @result_list.seq)

    correct_list = ResultList.where("sessionid=? and descrip='correct'", session.id.to_s).first
    correct_list.update(i_value: correct_list.i_value + 1)

    redirect_to :quiz_next
  end

  def quiz_miss
    logger.debug "-----quiz_miss-----"
    index_list = ResultList.where("sessionid=? and descrip='index'", session.id.to_s).first
    @result_list = ResultList.where("sessionid=? and descrip='word' and seq=?", session.id.to_s, index_list.seq.to_s).first
    last = ResultList.order(seq: "desc").first
    @result_list.update(i_value: last.i_value + 1)
    index_list.update(seq: @result_list.seq)

    miss_list = ResultList.where("sessionid=? and descrip='miss'", session.id.to_s).first
    miss_list.update(i_value: miss_list.i_value + 1)

    redirect_to :quiz_next
  end

  def quiz_next
    logger.debug "-----quiz_next-----"
    index_list = ResultList.where("sessionid=? and descrip='index'", session.id.to_s).first
    word_list = ResultList.where("sessionid=? and descrip='word' and seq > ?", session.id.to_s, index_list.seq)
    if (word_list.empty?)
      
      redirect_to :quiz_finish
    else
      @result_list = word_list.order(seq: 'asc').first
      index_list.update(seq: @result_list.seq)
    end
  end

  def quiz_test
    logger.debug "-----quiz_test-----"
    q = ResultList.order(seq: "desc").first
    logger.debug q.seq.to_s
  end

  def quiz_finish
    logger.debug "-----quiz_finish-----"
    start_time = ResultList.where("sessionid=? and descrip='starttime'", session.id.to_s).first
    finish_time = Time.now.seconds_since_midnight.to_i
    @elapsed_time = (finish_time - start_time.i_value).to_s

    correct = ResultList.where("sessionid=? and descrip='correct'", session.id.to_s).first
    @correct_count = correct.i_value
    miss = ResultList.where("sessionid=? and descrip='miss'", session.id.to_s).first
    @miss_count = miss.i_value.to_s
    @word_count = ResultList.where("descrip='word'").count
  end

  def next
    logger.debug "-----next-----" + session.id.to_s
    # url = request.original_url
    # logger.debug "=====" + url.to_s + "====="
    # u = URI.parse(url)
    # logger.debug "-----scheme " + u.scheme + "-----"
    # logger.debug "-----host " + u.host + "-----"
    # logger.debug "-----path " + u.path + "-----"
    # logger.debug "-----query " + u.query.to_s + "-----"
    # domain = u.host
    # if (domain == "localhost")
    #   domain = domain + ":3000"
    # end
    # logger.debug "-----domain " + domain + "-----"
    # if u.query
    #   p = CGI.parse(u.query)
    #   logger.debug "-----u " + u.query.to_s + "-----"
    #   logger.debug "-----p " + p.to_s + "-----"

    #   id = p['id'].first    # p is now {"id"=>["4"], "empid"=>["6"]
    # else
    #   id = 0
    # end
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
  end

  def unique_lessons
    logger.debug "-----unique_lesson-----"
    @lesson_list = VocabWord.uniq.pluck(:lesson)
    # logger.debug @lesson_list.to_s
    # logger.debug "----" + @lesson_list.to_s + "-----"
    # @lesson_list = @lesson_list.sort_by {|d| d.downcase}
    @lesson_list
      @lesson_list.each do |d|
      logger.debug "-----" + d + "-----"
    end
    # logger.debug @lesson_list.to_s
  end

  def choose_lesson
    logger.debug "-----choose_lesson-----"
    @use_lessons = params[:checkbox]
    logger.debug "-----" + params[:checkbox].to_s

    @quiz_word = []
    @use_lessons.each do |d, y|
      @quiz_word += VocabWord.where("lesson=?", d)
      logger.debug @quiz_word
    end

    @quiz_word2 = []
    @use_lessons.each do |d, y|
      @quiz_word2 += VocabWord.where("lesson=?", d)
      logger.debug @quiz_word2
    end

    # delete previous list
    #result_lists = ResultList.where("sessionid=?", session.id.to_s)
    result_lists = ResultList.all
    logger.debug "-----" + result_lists.to_s + "+++++"
    result_lists.delete_all
    # result_lists.each do |d|
    #   ResultList.delete(d.id)
    # end
    #result_lists.delete_all
    #logger.debug "---" + d.to_s + "---"
    #end

    sequence = 1
    #@quiz_word2 = @quiz_word
    @quiz_word2.shuffle!
    @quiz_word2.shuffle!
    @quiz_word.zip(@quiz_word2).each do |d1, d2|
      result_list = ResultList.new
      result_list.sessionid = session.id.to_s
      result_list.descrip = "word"
      result_list.s_value = d1.word + " " + d2.word
      result_list.seq = sequence
      result_list.save
      logger.debug "-----save " + d1.word + " " + d2.word + "-----" + sequence.to_s
      sequence += 1
    end
  end

  # POST /vocab_words
  # POST /vocab_words.json
  def create
    logger.debug "-----create-----"
    @vocab_word = VocabWord.new(vocab_word_params)
    logger.debug "-----before do-----"
    logger.debug "---" + vocab_word_params.to_s
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
    logger.debug "-----update-----"
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
