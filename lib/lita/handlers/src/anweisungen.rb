def get_answer (pathstructure)
  wegbeschreibung = ""
    
	pathstructure.each do |node|		
		if node.type.eql?("floor")||node.type.eql?("library")
			wegbeschreibung += " Gehen Sie zum #{node.description}."
		elsif node.type.eql? ("stairs")
			wegbeschreibung += " Begeben Sie sich in das #{node.description}."
		elsif node.type.eql? ("door")
			wegbeschreibung += " Gehen Sie durch den #{node.description}."
		elsif node.type.eql? ("elevator")
			wegbeschreibung += " Nehmen Sie den #{node.description}."
		elsif node.type.eql? ("mensa")
			wegbeschreibung += " Begeben Sie sich zur #{node.description}."
		elsif node.type.eql? ("lecturehall")
  		wegbeschreibung += " Öffnen Sie die Tür zum #{node.description} und begeben Sie sich hinein"
		end
	end
	return wegbeschreibung
end