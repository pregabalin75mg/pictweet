class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  # editとshowが同じ記述なのでbefore_actionでひとまとめにした。set_tweetの定義は下にあり。
  # before_action :move_to_index, except:[:index, :show ,:search] 
  # indexとshowとsearch以外はmove_to_indexを行う。これは下に定義した。
  # =>閲覧、詳細を見る、検索は未ログインでもできる。投稿とかはトップページへ強制的に移動させる。

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)  # 元々の入力は下。N+1問題の解消のためincludesメソッドを使用
    # (@tweets = Tweet.all)  # @tweets はビューに行く。Tweet はモデルに行きtweetテーブルを呼び起こす。.allのため情報は全てもってくるよう指示している。
    # .orderで並び替え(並び替え基準にするもの 並び順) 並び順はASC(昇順) or DESC(降順)
    # (params[:page])は数字で何ページ目を表示するのかを示して入る。
    # 1つのページに何項目載せるのかを決める。
  end

  def new 
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end


  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
    # (tweetsテーブル上の) user_id と (userテーブル上の現在ログインしているユーザの[current_user.]_ ) id を結びつける(merge)。
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
    # unless user_sign_in?が先に処理される。返り値がfalseの場合redirect_to が発動
    # unless:〜でない限り 〜でなければ
  end

end