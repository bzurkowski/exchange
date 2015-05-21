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
        yield [true, stack]
      end

      unless visited[neighbour[:tail]]
        dfd_find_cycle(graph, starting_vertice, neighbour[:tail], neighbour[:demand], stack, visited) do |result, stack|
          yield [true, stack] if result
        end
      end
    end

    visited[current_vertice] = false
    stack.pop
    [false, stack]
  end

  def find_cycles
    graph_copy = graph.clone

    while graph_copy.vertices.any?
      vertice = graph_copy.vertices[0]
      visited = Hash.new(false)

      dfd_find_cycle(graph, vertice, vertice, nil, [], Hash.new(false)) do |result, stack|
        yield stack if result
      end

      graph_copy.vertices.delete vertice
      graph_copy.edges.delete_if { |edge| [edge[:head], edge[:tail]].include? vertice }
    end
  end
end
