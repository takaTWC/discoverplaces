# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

  private
  # アクティブであるかを判断するメソッド
  def user_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    return if user.nil?
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
    # 【処理内容4】 アクティブでない会員に対して新規会員登録ページへ遷移する
    if user.is_active
      create
    else
      flash[:notice] = "お客様のアカウントは退会が完了しています。"
      redirect_to new_user_registration_path
    end
  end
end
