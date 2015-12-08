class AnimalsController < ApplicationController
  def new
    logger.debug "-----animals create-----"
    @animal = Animal.new
  end

  def create
    logger.debug "-----animals create-----"
    if verify_recaptcha
      logger.debug "-----verify_recaptcha-----"
      render 'show'
    else
      logger.debug "-----no verify_recaptcha-----"
      #@animal = Animal.new
      #render 'new'
      redirect_to new_animal_path
    end
  end

  def mycallback
    logger.debug "-----animals mycallback-----"
    logger.debug params.inspect
    if verify_recaptcha
      render 'new'
    else
      redirect "/"
    end
  end
end
