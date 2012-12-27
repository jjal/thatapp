class SubscribersController < ApplicationController
  # GET /subscribers/new
  # GET /subscribers/new.json
  def new
    @subscriber = Subscriber.new

    render layout: "blank"
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.save
      flash[:info] = "Thanks for your interest! We'll keep you updated on developments with that app as they happen!"
      redirect_to root_url
    else
      @feed_items = []
      redirect_to root_url
    end
  end
end
