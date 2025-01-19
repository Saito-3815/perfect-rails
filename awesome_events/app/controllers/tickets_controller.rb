class TicketsController < ApplicationController
  # ログイン状態で直接URLを叩かれた場合にエラーを発生させる
  # 未ログイン状態の挙動は、ApplicationControllerで定義
  def new
    raise ActionController::RoutingError, 'ログイン状態で TicketController#new にアクセス'
  end

  def create
    event = Event.find(params[:event_id])
    @ticket = current_user.tickets.build do |t|
      t.event = event
      t.comment = params[:ticket][:comment]
    end
    if @ticket.save
      redirect_to event, notice: 'このイベントに参加表明しました'
    end
  end

  # このアクションは必ずリダイレクトされるため、ビューに渡すインスタンス変数は不要
  def destroy
    # !でレコードが見つからない場合と削除失敗時に例外を発生させる
    ticket = current_user.tickets.find_by!(event_id: params[:event_id])
    ticket.destroy!
    redirect_to event_path(params[:event_id]), notice: 'このイベントの参加をキャンセルしました'
  end
end
