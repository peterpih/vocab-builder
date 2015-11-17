class SayController < ApplicationController
  def hello
  	logger.debug "-----SayController.hello-----"
  	@time = Time.now
  end

  def goodbye
  	logger.debug "-----SayController.goodbye-----"
  end
end
