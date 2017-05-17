module ApplicationHelper

  def new_or_edit_h1
    if 'new' == params[:action]
      return '新規チャットグループ'
    else
      return 'チャットグループ編集'
    end
  end
end
