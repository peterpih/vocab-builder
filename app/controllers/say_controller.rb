class SayController < ApplicationController
  def hello
  	logger.debug "-----SayController.hello-----"
  	@time = Time.now
    @message = VocabWord.new
  end

  def goodbye
  	logger.debug "-----SayController.goodbye-----"
  end

  def test
    logger.debug "-----say_test-----"
    logger.debug "-----" + params[:group1].inspect
  end
end
