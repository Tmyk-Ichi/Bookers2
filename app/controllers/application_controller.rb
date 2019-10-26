class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
  user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
  root_path
  end

  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    # アカウント編集の時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


end

Refile.secret_key = '690eb9bd619be89aaa9bca9171b0fa8e391c10850f796583ef5e49fd66e939432d682a7795153bad9e1f7d205919b9c78db27731c787030196396b1af97495bf'