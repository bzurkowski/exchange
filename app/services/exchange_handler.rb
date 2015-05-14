class ExchangeHandler
  attr_reader :exchange

  def initialize(exchange:)
    @exchange = exchange
  end

  def make
    return unless exchange.accepted?

    ActiveRecord::Base.transaction do
      exchange.demands.each do |demand|
        offer = demand.offer
        offer.accepted!

        offer.assignation.update term: demand.term
      end

      exchange.destroy
    end
  end
end
