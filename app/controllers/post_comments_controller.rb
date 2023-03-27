class PostCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book = book
    if comment.save
      redirect_to book_path(book.id), notice: "You have posted comment successfully"
    else
      @book = Book.find(params[:book_id])
      @user = current_user
      @post_comments = PostComment.all
      @post_comment = comment
      render "books/show"
    end
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
  def ensure_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to book_path(@book.id)
    end
  end
end
