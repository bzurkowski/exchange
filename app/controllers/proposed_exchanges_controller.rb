class ProposedExchangesController < ApplicationController
  before_filter :set_exchange, only: [:show, :accept, :reject]

  def show
  end

  def index
    @exchanges = ProposedExchange.only_involved_with(current_user).decorate
  end

  def accept
    if @exchange.accept(user: current_user)
      redirect_to proposed_exchanges_path
    else
      redirect_to proposed_exchanges_path
    end
  end

  def reject
  end

  private

  def set_exchange
    @exchange = ProposedExchange.find(params[:id])
  end
end
