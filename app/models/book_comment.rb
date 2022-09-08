class BookComment < ApplicationRecord
    belongs_to :user
    belongs_to :book
    
    def create
        book = Book.find(params[:book_id])
        comment = current_user.book_comments.new(book_comment_params)
        comment.book_id = book.id
        comment.save
        redirect_to request.referer
    end
    
    def show
        @book = Book.find(params[:id])
        @book_comment = BookComment.new
    end
    
    def destroy
        BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
        redirect_to request.referer
    end
    
    private
    
    def ensure corrent_user
        @book = Book.find(params[:id])
        unless @book.user == current_user
            redirect_to books_path
        end
    end
    
    def book_params
    params.require(:book).permit(:title, :body)
    end
    
end
