class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comment.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
    render :book_comment
  end

  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    render :book_comment
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment,:book_id,:user_id)
  end

end
