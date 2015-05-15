class ExchangeUpdater
  attr_reader :subject

  def initialize(subject)
    @subject = subject
  end

  def update_exchanges
    remove_invalid_exchanges
    add_new_exchanges
  end

  private

  def remove_invalid_exchanges
    # TODO: maybe something less drastic
    ProposedExchange.where.not(demands_hash: exchanges.map(&:demands_hash)).destroy_all
  end

  def add_new_exchanges
    previous_exchanges = ProposedExchange.pluck(:demands_hash)
    exchanges.delete_if { |exchange| previous_exchanges.include? exchange.demands_hash }

    exchanges.map(&:save!)
  end

  def exchanges
    @exchanges ||= finder.exchanges
  end

  def finder
    @finder ||= ExchangeFinder.new(graph: subject_graph)
  end

  def subject_graph
    @subject_graph ||= SubjectGraphBuilder.build(subject: subject)
  end
end
