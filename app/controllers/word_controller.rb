class VocabWordController < ApplicationController

	def index
		@words = VocabWord.all
	end
		
	def show
		render plain: params[:id].inspect
	end

	def new
		@word = VocabWord.new
	end
end
