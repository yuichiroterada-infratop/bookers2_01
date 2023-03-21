class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
  end

end
