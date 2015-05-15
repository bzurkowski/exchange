class ProposedExchangeDecorator < Draper::Decorator
  delegate_all

  def accepted_by_user?(user)
    proposed_exchange_demands.where(demand: demands.owned_by(user)).all? do |demand|
      demand.accepted?
    end
  end
end
