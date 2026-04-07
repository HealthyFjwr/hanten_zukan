class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # Googleから返ってきた認証情報（auth）を使ってユーザーを検索 or 作成
    # request.env['omniauth.auth'] に uid, email, name などが入っている
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      # persisted? = DBに保存済み = ログイン成功
      # sign_in_and_redirect でセッションを張ってリダイレクト
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      # 保存失敗（バリデーションエラーなど）の場合は登録画面へ
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def failure
    # 認証失敗時（キャンセルされた場合など）はログイン画面へ
    redirect_to new_user_session_path, alert: 'Google認証に失敗しました'
  end
end
