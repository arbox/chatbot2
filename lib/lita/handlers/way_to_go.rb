# encoding: utf-8
require_relative 'src/anfragen'
require_relative 'src/graph'
require_relative 'src/anweisungen'

module Lita
  module Handlers
    class WayToGo < Handler

      # Automatically load XML and create Graph when Handler is instantiated.
      def initialize(robot)
        # Call the original constructor
        super
        # Create a graph, which by default loads its data from campusgraph.xml
        @graph = Graph.new
      end

      # route
      route(/(.*)/, :anfrage, command:false, help:{"anfrage: get VALUE"=>"returns a command"})

      def anfrage(response)
        # Extract the actual chat message with our request.
        request = response.matches[0][0]
        # Extract start and destination as strings.
        points = get_points(request)
        if Array(points).count == 2
          # Get a list of nodes for the way from start to destination.
          pathstructure = get_path(points)
          # Generate a string as answer for the request.
          answer = get_reply(pathstructure) 
          response.reply(answer)
        else
          # get_points has just returned a string telling us to restate our request 
          response.reply(points)
        end
      end


      # Anfragegruppe
      def get_points(request)
        points = get_start_stop(request)
        return points
      end


      # Datengruppe
      def get_path (points)
        pathstructure = Array.new
        if @graph.respond_to? 'get_path_by_names'
          pathstructure = @graph.get_path_by_names(points[0], points[1])
        end
        pathstructure
      end


      # Anweisungsgruppe
      def get_reply(pathstructure)
        return get_answer(pathstructure)
      end


      Lita.register_handler(self)
    end
  end
end
