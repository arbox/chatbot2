
def get_start_stop (input)
  result = input.scan(/.*(\w[\- ]*Gebäude|Mensa|Raum \w\d+|[A-Z]\d+|\d+[\. ] Stockwerk).*(\w[\- ]*Gebäude|Mensa|Raum \w\d+|[A-Z]\d+|\d+[\. ] Stockwerk)/i)

  if result.empty? == false
    return result[0]
  else
    return "Formulieren Sie ihre Anfrage bitte anders."
  end

end
