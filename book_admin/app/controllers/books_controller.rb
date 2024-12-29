class BooksController < ApplicationController
  protect_from_forgery except: :destroy # CSRF対策のセキュリティトークンを無効化する
  before_action :set_book, only: [:show, :destroy]
  around_action :action_logger, only: [:destroy] # around_actionメソッドを使うと、アクションの前後で任意の処理を実行できる

  def show
    respond_to do |format| # リクエストに応じてレスポンスを分岐する。/books/:id.jsonでアクセスするとjson形式で返す
      format.html
      # format.json { render json: @book }
      format.json
    end
    # render :show
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  # around_actionメソッドで指定したアクションの前後で実行される処理
  def action_logger
    logger.info "around-before"
    yield # ここでアクションの処理が実行される
    logger.info "around-after"
  end
end
