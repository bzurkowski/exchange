class SubjectGraphBuilder
  Graph = Struct.new(:vertices, :edges) do
    def neighbouring_vertices_of(vertice)
      edges.inject([]) do |list, edge|
        list.push(edge) if edge[:head] == vertice
        list
      end
    end
  end

  def self.build(subject:)
    vertices = subject.terms.to_a
    offers   = Offer.active.joins(:assignation).where(assignations: { term_id: vertices }).includes(assignation: [:term])
    edges    = offers.map { |offer| generate_edges_for_offer(offer) }.flatten

    Graph.new vertices, edges
  end

  private

  def self.generate_edges_for_offer(offer)
    offer.demands.map do |demand|
      { demand: demand, head: offer.assignation.term, tail: demand.term }
    end
  end
end
