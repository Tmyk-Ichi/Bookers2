class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only:[:edit, :update, :destroy]}

  def ensure_correct_user
     @book = Book.find(params[:id])
     if @book.user_id != current_user.id
     redirect_to books_path
     end
  end


	def show
		@book = Book.find(params[:id])
        @newbook = Book.new
        @user = @book.user
	end

	def index
		@books = Book.all
		@newbook = Book.new
		@user = current_user
		@book = Book.new
	end

	def new
		@newbook = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
        if @book.save
        flash[:notice] = "You have created book successfully"
        redirect_to book_path(@book.id)
        else
        @books= Book.all
        @user = current_user
        @newbook = Book.new
        render :index
        end
	end

	def edit
		@book= Book.find(params[:id])
	end

	def update
		@book = Book.find_by(id: params[:id])
	  	if @book.update(book_params)
	  	#保存できた場合
	    redirect_to book_path(@book)
	    flash[:notice] = "Book was successfully updated."
	    else
	    #保存できなかった場合
	    render :edit
	    end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

    private

	def book_params
        params.require(:book).permit(:title, :body, :user_id)
    end

end