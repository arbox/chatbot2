# encoding: utf-8

puts $LOAD_PATH

require 'nokogiri'
require 'rgl/adjacency'
require 'rgl/traversal'
require 'rgl/dijkstra'


class Vertex
  attr_accessor :type           # e.g. 'floor' or 'elevator'
  attr_accessor :description    # e.g. 'Erdgeschoss des A-Gebäudes'

  def initialize(name, type, desc)
    @name = name
    @type = type
    @description = desc
  end

  def to_s
    e = @description.to_s.empty? ? true : false
    if e
      puts "WARNING: node #{@name} lacks a description!"
    end
    e ? "#@name (#@type)" : "#@description"
  end
end


class Graph

  def initialize()
    @graph, @weight_map = read_from_file()
  end
  
  def read_from_file(filename='campusgraph.xml')
    # Parse the XML file.
    filepath = File.join(File.dirname(__FILE__), '..', '..', '..', 'data', filename)
    g = Nokogiri::XML(File.open(filepath))
    xml_nodes = g.css("nodes node")
    xml_edges = g.css("edges edge")

    # Build a hash of vertices.
    vertices = Hash.new
    weight_map = Hash.new
    xml_nodes.each { |v|
      n = v['name']
      vertices[n] = Vertex.new(v['name'], v['type'], v['desc'])
    }

    # Build a hash of edge-weights, using the previously created vertices.
    xml_edges.each { |e|
      src = vertices[e['from']]
      dst = vertices[e['to']]
      w = Integer(e['weight']) or 999
      weight_map[[src, dst]] = w
    }

    # Create a RGL Graph to represent our campusgraph.
    # It implements Dijkstra's algorithm to search for 
    # 'shortest paths' from A to B.
    graph = RGL::AdjacencyGraph.new
    graph.add_vertices(vertices)        
    weight_map.each { |(src, dst), w| graph.add_edge(src, dst) }

    return [graph, weight_map]
  end

  # Get the shortest path from start to stop.
  # Both start and stop have to be Vertex objects from our graph.
  def get_path(start, stop)
    @graph.dijkstra_shortest_path(@weight_map, start, stop)
  end

  # Get the shortest path from start to stop.
  # Both start and stop are strings and are looked up automatically.
  def get_path_by_names(start, stop)
    s1 = get_node(start)
    s2 = get_node(stop)
    if s1 != nil && s2 != nil
      return get_path(s1, s2)
    end
    Array.new 
  end

  # Get a Vertex object which matches a given string representation.
  def get_node(string)
    # Let's do a case insensitive search..
    string = string.downcase()
    results = @graph.vertices[0].select { |k,v|
      d = v.description
      d.downcase().include? string
    }
    if results.count >= 1
      if results.count > 1
        puts "WARNING: More than one node matches '#{string}'! Simply using the first one..."
      end
      # Just use the "first" node available, whatever that might mean...
      node = Array(results)[0][1]
    else
      puts "WARNING: No nodes matches '#{string}'!"
      node = nil
    end
    return node
  end
end


if __FILE__ == $0
  # Example usage
  g = Graph.new
  start = g.get_node("d-gebäude")
  stop = g.get_node("eingangsbereich der mensa")
  puts "Weg vom #{start} zum #{stop}:"
  path = g.get_path(start, stop)
  puts path

  start = "zweiten stock des a-gebäudes"
  stop = "somewhere in the vicinity of betelgeuze"
  puts "Weg vom #{start} zum #{stop}:"
  path = g.get_path_by_names(start, stop)
  puts path

  # Known to crash RGL
  start = g.get_node("d-gebäude")
  stop = g.get_node("mensa") # mensa im f gebäude auf campus 2 --> kein Pfad!
  path = g.get_path(start, stop)
end
