	def get_answer (pathstructure)
        wegbeschreibung = ""
        
        	pathstructure.each do |step|		
        			if node.type.eql?("floor")||type.eql?("library")
        				wegbeschreibung += " Gehen Sie zum #{node.desc}."
        			elsif node.type.eql? ("stairs")
        				wegbeschreibung += " Begeben Sie sich in das #{node.desc}."
        			elsif node.type.eql? ("door")
        				wegbeschreibung += " Gehen Sie durch den #{node.desc}."
        			elsif node.type.eql? ("elevator")
        				wegbeschreibung += " Nehmen Sie den #{node.desc}."
        			elsif node.type.eql? ("mensa")
        				wegbeschreibung += " Begeben Sie sich zur #{node.desc}."
        			elsif node.type.eql? ("lecturehall")
        				wegbeschreibung += " Öffnen Sie die Tür zum #{node.desc} und begeben Sie sich hinein"
        		end
        	end
        	return wegbeschreibung
    end