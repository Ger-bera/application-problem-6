class SearchesController < ApplicationController

  def search
    @range = params[:range]
    method = params[:search]
    word = params[:word]
    if @range == '1'
      @user = User.search(method,word)
    else
      @book = Book.search(method,word)
    end
  end

end
