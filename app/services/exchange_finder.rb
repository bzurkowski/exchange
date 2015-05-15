class ExchangeFinder
  attr_accessor :graph

  def initialize(graph:)
    @graph = graph
  end

  def exchanges
    exchanges = []
    find_cycles do |cycle|
      demands = cycle.map { |pair| pair[:demand] }
      exchange = ProposedExchange.new subject: demands[0].term.subject, demand_ids: demands.map(&:id)
      exchange.set_demands_hash
      exchanges.push exchange
    end
    exchanges
  end

  private

  def dfd_find_cycle(graph, starting_vertice, current_vertice, last_edge, stack, visited)
    visited[current_vertice] = true
    stack.push(term: current_vertice, demand: last_edge)

    graph.neighbouring_vertices_of(current_vertice).each do |neighbour|
      if neighbour[:tail] == starting_vertice
        stack[0][:demand] = neighbour[:demand]
        return [true, stack]
      end

      unless visited[neighbour]
        result, stack = dfd_find_cycle(graph, starting_vertice, neighbour[:tail], neighbour[:demand], stack, visited)
        return [true, stack] if result
      end
    end

    stack.pop
    [false, stack]
  end

  def find_cycles
    used_vertices = []

    graph.vertices.each do |vertice|
      visited = Hash.new(false)
      result, stack = dfd_find_cycle(graph, vertice, vertice, nil, [], Hash.new(false))

      yield stack if result and stack.select { |pair| used_vertices.include? pair[:term] }.none?
      used_vertices.push vertice
    end
  end
end
