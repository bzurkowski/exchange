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
end
