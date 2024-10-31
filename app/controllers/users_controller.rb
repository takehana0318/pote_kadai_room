class UsersController < ApplicationController
  before_action :authenticate_user!

  def account
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user

    # パスワードフィールドが空欄の場合、パラメータから除外
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to edit_profile_path, notice: 'プロフィールが更新されました。'
    else
      puts @user.errors.full_messages  # エラーメッセージをデバッグ用に出力
      render :edit_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :icon, :bio, :password, :password_confirmation)
  end
end
