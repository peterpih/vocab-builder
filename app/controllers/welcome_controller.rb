class WelcomeController < ApplicationController

  # GET /welcome
  def index
  	#
  	# if render here, then views/welcome/index.html.erb will not be used
    # render text: "Welcome to VocaBuilder!"
    logger.debug "-----WelcomeController index-----"
    session[:foo] = "bar"
    logger.debug "-----WelcomeController index-----" + session.id.to_s
  end

end
