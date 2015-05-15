class ExchangeMakerJob
  @queue = :exchanges_update

  def self.perform(exchange_id)
    exchange = ProposedExchange.find(exchange_id)

    ExchangeHandler.new(exchange: exchange).make
  end
end
