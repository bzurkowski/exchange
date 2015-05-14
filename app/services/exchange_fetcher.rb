class ExchangeFetcher
  attr_accessor :subject

  def initialize(subject:)
    @subject = subject
  end

  def fetch_exchanges(user: nil)
    exchanges = ProposedExchange.where(subject: subject)
    exchanges = exchanges.only_involved_with(user) if user.present?
    exchanges
  end

  def update_exchanges
    graph     = SubjectGraphBuilder.build subject: subject
    finder    = ExchangeFinder.new graph: graph
    exchanges = finder.exchanges

    remove_invalid_exchanges(exchanges)
    add_new_exchanges(exchanges)
  end

  private

  def remove_invalid_exchanges(exchanges)
    # TODO: maybe something less drastic
    ProposedExchange.where.not(demands_hash: exchanges.map(&:demands_hash)).delete_all
  end

  def add_new_exchanges(exchanges)
    previous_exchanges = ProposedExchange.pluck(:demands_hash)
    exchanges.delete_if { |exchange| previous_exchanges.include? exchange.demands_hash }

    exchanges.map(&:save!)
  end
end
