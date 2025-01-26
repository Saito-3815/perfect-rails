class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    # kaminariを追加することでpage, perメソッドが使えるようになる
    # pageメソッドでページ番号を指定し、perメソッドで1ページあたりの表示件数を指定
    # perを指定しない場合はデフォルトの25件が表示される
    @events = Event.page(params[:page]).per(10).
      where("start_at >  ?", Time.zone.now).order(:start_at)
  end
end
