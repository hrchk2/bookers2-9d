class BookCommentsController < ApplicationController
  def create
    @book =Book.find(params[:book_id])
    @book_comment =current_user.book_comments.new(book_comment_params)
    @book_comment.book_id= @book.id
    if @book_comment.save
      render :create
    else 
      @booknew =Book.new
      @user =@book.user
      render "books/show"
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
