module Lita
  module Handlers
    class WayToGo < Handler
      
      # All the routes
      route(/way\sto\s+([a-zA-Z0-9-]*)(.*)/, :where, command: true, help: {"way to LOCATION" => "Tells you the way to LOCATION."})
      route(/answer|life|universe/, :fortytwo, command: true, help: {"life, the universe, and everything" => "the answer to it"})
      route(/add\s+(\d+)\s+(\d+)/, :add, command: true, help: {"add N1 N2" => "Calculates N1 + N2"})
      route(/^say\s.*/,:say, command:false, help:{"dummy-command: say TEXT" => "replies with text" })
      route(/^[Hh]ow.*|^[Ww]here.*/,:dir, command:false, help:{"dummy-command: ASK FOR DIRECTIONS" => "returns useful advice"})   
      route(/get .*/, :get, command:false, help:{"dummy-command: get VALUE"=>"returns corresponding value if available"})


      # All the callbacks
      def where(response)
      	location = response.matches[0][0]
      	reply = [
      		"Many paths lead to #{location}.",
      		"I cound tell you the way to #{location} but it is always more exciting to find out on your own!",
      		"Are you sure this location exists? I have never heard of #{location}.",
      		"That is simple. Just go [x0532~a3d31204b8\\xxDYz and then turn fdsdsHHHdsf. No problem, your welcome. :)"
      	].sample
      	response.reply(reply)
      end

      def add(response) 
      	n1 = to_number(response.matches[0][0] || '')
      	n2 = to_number(response.matches[0][1] || '')
      	result = n1 + n2
      	response.reply "#{result}"
      end

      def fortytwo(response)
      	response.reply "The answer is 42. Think about it."
      end
    
      
      def say(response)
        i = 10
        response.reply "Self-destruction initiated."
        every(1) do |timer| 
          response.reply(i.to_s)
          i -= 1
          timer.stop if i == 0
        end
      end

      def dir(response)
        @a = ["Always straight ahead!","Huh, I don't know, we should ask someone...","What kind of question is that supposed to be??","Around the corner."]
        r = rand(0..3)        
        response.reply(@a[r])
      end

      def get(response) 
        @h = { "answer" => "42", "a" => "2"}        
        if @h.key?(response.matches[0][4]) == false  
          response.reply("#{response.matches[0][4]} is not in the database")
        else
        response.reply(@h[response.matches[0][4..10]])
        end
      end


      # Helper function
      def to_number(s)
      	n  =Integer(s)
      rescue ArgumentError
      	0
      end

      Lita.register_handler(self)
    end
  end
end
