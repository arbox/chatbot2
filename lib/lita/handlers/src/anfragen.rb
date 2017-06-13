def get_start_stop (input)
  result = input.scan(/.*(\w[\- ]*Gebäude|Mensa|[Bb]ib[liothek]*|Raum \w\d+|[A-Z]\d+|\d+[\. ] Stockwerk).*(\w[\- ]*Gebäude|Mensa|[Bb]ib[liothek]*|Raum \w\d+|[A-Z]\d+|\d+[\. ] Stockwerk)/i)

  if result.empty? == false
    return result[0]
  else
      greeting = return_greeting(input)
      if greeting.empty? == false
        return greeting
      else
        return "Bitte formulieren Sie ihre Anfrage neu."
      end
    end
end


def return_greeting (input)
  input = input.strip()
  greetings = {
    "Hallo" => [ "Hi", "Guten Tag!!" ],
    "Hi" => [ "Hallo" ],
    "Guten Morgen!" => [ "Hallo","Danke dir","Guten Morgen!." ],
    "Hi, wie geht es dir?" => [ "Mir geht es gut","Ganz okay","Super","Großartig","Könnte besser sein","Nicht so gut" ],
    "Wie geht es dir?" => [ "Gut","Ganz gut, danke","Gut, und dir?" ],
    "Schön dich zu sehen" => [ "Dankeschön." ],
    "Wie gehts?" => [ "Geht ganz gut","Mir gehts gut. Wie geht es dir?" ],
    "Hi, schön dich zu treffen" => [ "Danke, gleichfalls." ],
    "Es ist eine Freude dich zu sehen" => [ "Dankeschön, freut mich auch" ],
    "Was geht?" => [ "Nicht so viel","Nicht wirklich viel","Nicht viel, und bei dir?","Nichts","Die Sonne scheint und mir geht es gut. Wie sieht es mit dir aus?" ]
  }
  greeting = greetings[input]

  begin
    return greeting[rand(0..greeting.length-1)]
  rescue
    return []
  end

end
