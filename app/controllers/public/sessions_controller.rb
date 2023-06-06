# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_status, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインに成功しました。"
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトに成功しました。"
    root_path
  end


  protected

  # ログインしようとしたユーザーが退会済みなら新規登録画面へ遷移させる。
  def user_status
    @user = User.find_by(email: params[:user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user

    ##取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    ##ユーザーが退会済みなら新規登録画面に遷移させる
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted
      flash[:notice] = "退会済みの為、再度ご登録してご利用ください"
      redirect_to new_user_registration_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
  end

end
