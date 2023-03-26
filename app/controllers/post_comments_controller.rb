class PostCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book.id)
  end
  
  def destroy
    ensure_user
    
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
