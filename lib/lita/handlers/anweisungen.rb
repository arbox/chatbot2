require 'nokogiri'

	def get_answer (pathstructure)
        wegbeschreibung = ""
        begrüßung = "Willkommen zum Campusnavi!!!"
        verabschiedung = " Das hat Sie 50 Euro gekostet. Wir danken für ihre Kooperation !"
        
        	pathstructure.each_with_index do |step,i|
        		target = get_target(step) #bestimmt Ziel des aktuellen Knotens
        		type = get_type(target) #bestimmt Typ des Zielknotens
        		
        			if type.eql?("floor")||type.eql?("library")
        				wegbeschreibung += " Gehen Sie zum #{get_descr(target)}."
        			elsif type.eql? ("stairs")
        				wegbeschreibung += " Begeben Sie sich in das #{get_descr(target)}."
        			elsif type.eql? ("door")
        				wegbeschreibung += " Gehen Sie durch den #{get_descr(target)}."
        			elsif type.eql? ("elevator")
        				wegbeschreibung += " Nehmen Sie den #{get_descr(target)}."
        			elsif type.eql? ("mensa")
        				wegbeschreibung += " Begeben Sie sich zur #{get_descr(target)}."
        			elsif type.eql? ("lecturehall")
        				wegbeschreibung += " Öffnen Sie die Tür zum #{get_descr(target)} und begeben Sie sich hinein"
        		end
        	end
        	return begrüßung + wegbeschreibung + verabschiedung
    end
    
    def read_campusgraph
    	## liest den Campusgraph ein zur weiteren Verarbeitung
    	path = File.expand_path('../../../.') + "/data/campusgraph.xml"
    	page = Nokogiri::XML(File.open(path)) do |parse|
    		parse.strict.noblanks
   		end
   		return page
    end
      
    def get_target (edge)
      	  ## liefert Ziel einer Kante als Name eines Knotens
      	  xml_doc = Nokogiri::XML(edge)
      	  return xml_doc.xpath("edge/@to")
    end
      
    def get_type (nodename)
    	## liefert Type Attribut des Knotens mit Name = nodename
      	xml_doc = read_campusgraph                             
      	xmlString = xml_doc.xpath("//*[@name='#{nodename}']")
      	type = Nokogiri::XML(xmlString.to_s)
      	return type.xpath("node/@type").to_s
    end
      
    def get_descr (nodename)
    	## liefert Desc Attribut des Knotens mit Name = nodename
      	xml_doc = read_campusgraph                             
      	xmlString = xml_doc.xpath("//*[@name='#{nodename}']")
      	type = Nokogiri::XML(xmlString.to_s)
      	return type.xpath("node/@desc")
    end
    
    beispielpfad = ['<edge from="b0door2" to="b0door3" weight="999"/>','<edge from="c0" to="cs1" weight="1"/>','<edge from="f0" to="fmensa" weight="1"/>']
    
    puts get_answer(beispielpfad)