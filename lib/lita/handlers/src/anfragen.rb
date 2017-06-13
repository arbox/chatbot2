
def get_start_stop (input)
  result = input.scan(/.*(\w[\- ]*Gebäude|Mensa|[Bb]ib[liothek]*|Raum \w\d+|[A-Z]\d+|\d+[\. ] Stockwerk).*(\w[\- ]*Gebäude|Mensa|[Bb]ib[liothek]*|Raum \w\d+|[A-Z]\d+|\d+[\. ] Stockwerk)/i)

  if result.empty? == false
    return result[0]
  else
      return "Bitte formulieren Sie ihre Anfrage neu."
    end

end
