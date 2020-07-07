class CreditcardsController < ApplicationController
  require "payjp"
  def new
    creditcard = Creditcard.where(user_id: current_user.id)
    redirect_to action: "show" if card.exists?
  end
end
