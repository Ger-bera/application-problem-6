class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @booker = Book.new(book_params)
    @booker.user_id = current_user.id
    if @booker.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@booker.id)
    else
      @books = Book.all
      @users = User.all
      render :index
    end
  end

  def index
    @users = User.all
    @books = Book.all
    @booker = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
    @books = Book.all
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

   private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
