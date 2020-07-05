class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")

    # @nickname = current_user.nickname    current_user.nicknameでは自分自身以外のユーザーのマイページが見られない。
    # @tweets = current_user.tweets        =>他ユーザーのマイページをクリックしても自分のマイページへ推移してしまう。
  end
end
