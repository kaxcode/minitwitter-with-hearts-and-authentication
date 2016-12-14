class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  # GET /tweets
  def index
    @tweets = Tweet.all.order("created_at DESC")
  end

  # GET /tweets/1
  def show
    @tweet = Tweet.find(params[:id])
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_name = current_user.email

    if @tweet.save
      redirect_to tweets_path, notice: 'Tweet was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tweets/1
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: 'Tweet was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_url, notice: 'Tweet was successfully destroyed.'
  end

  # likes/hearts feature
  def upvote
    @tweet = Tweet.find(params[:id])
    @tweet.votes.create(upvote:true)

    redirect_to tweets_path
  end

  private
    # Only allow a trusted parameter "white list" through.
    def tweet_params
      params.require(:tweet).permit(:text, :user_name)
    end
end
