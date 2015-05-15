class ExchangesUpdateJob
  @queue = :exchanges_update

  def self.perform(subject_id)
    subject = Subject.find(subject_id)

    ExchangeUpdater.new(subject).update_exchanges
  end
end
