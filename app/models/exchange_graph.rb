class ExchangeGraph
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :subject
  attr_reader   :graph, :finder, :results
  validates_presence_of :subject

  def self.find_by_subject(subject)
    Rails.cache.fetch "graphs/#{subject.id}" do
      new(subject: subject).tap(&:calculate)
    end
  end

  def calculate
    return false unless valid?

    @graph   = SubjectGraphBuilder.build subject: subject
    @finder  = ExchangeFinder.new graph: graph
    @results = @finder.exchanges
  end
end
