module Lita
  module Handlers
    class WayToGo < Handler
      
      # route
      route(/(.*)/, :anfrage, command:false, help:{"anfrage: get VALUE"=>"returns a command"})
    
      def anfrage(response)
        request = response.matches[0][0]
            
        points = get_points (request) # return a list of two string (start, stop)
        pathstructure = get_path (points) # return a list of nodes for the way 
        answer = get_answer (pathstructure) # return a string as answer for the request
        
        response.reply(points) # change arg for group for testing
        
      end
      
      # Anfragegruppe
      def get_points(request)
        
      end
      
      # Anfragegruppe
      def get_points(request)
        
        tokens = request.split(' ')
        

        points = tokens
        return points
      end
      
      
      
      # Datengruppe
      def get_path (points)
        pathstructure = []
        
        
        return pathstructure
      end
      
      
      # Anweisungsgruppe
      def get_answer (pathstructure)
        wegbeschreibung = ""
        
      
        return wegbeschreibung
      end


      Lita.register_handler(self)
    end
  end
end
