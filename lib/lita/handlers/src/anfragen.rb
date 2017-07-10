def get_start_stop (input)

  regex_tester = /(Hörsaal \d+|[Tt]reppenhaus| [A-Za-züäö ]+[Ee]ingang des \w+-Gebäudes|Eingang des \w+-Gebäudes|Eingang des Mensa-Gebäudes| [A-Za-züäö ]+eingang des Mensa-Gebäudes|Eingangsbereich der Mensa|Aufzug|Audimax|Bibliothek| \w* Stock des \w+-Gebäudes| \w*geschoss des \w+-Gebäudes)/
  result = input.scan(/.*#{regex_tester}.*#{regex_tester}.*/)

  if result.empty? == false
    result[0][0] = result[0][0].strip()
    result[0][1] = result[0][1].strip()
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
  input = input.downcase.gsub(/[^[:word:]\s]/, '')
  greetings = {
    "hallo" => [ "Hi", "Guten Tag!!" ],
    "hi" => [ "Hallo" ],
    "guten Morgen" => [ "Hallo","Danke dir","Guten Morgen!" ],
    "hi wie geht es dir" => [ "Mir geht es gut","Ganz okay","Super","Großartig","Könnte besser sein","Nicht so gut" ],
    "wie geht es dir" => [ "Gut","Ganz gut, danke","Gut, und dir?" ],
    "schön dich zu sehen" => [ "Dankeschön." ],
    "wie gehts" => [ "Geht ganz gut","Mir gehts gut. Wie geht es dir?" ],
    "hi, schön dich zu treffen" => [ "Danke, gleichfalls." ],
    "es ist eine Freude dich zu sehen" => [ "Dankeschön, freut mich auch" ],
    "was geht" => [ "Nicht so viel","Nicht wirklich viel","Nicht viel, und bei dir?","Nichts","Die Sonne scheint und mir geht es gut. Wie sieht es mit dir aus?" ]
  }
  greeting = greetings[input]

  begin
    return greeting[rand(0..greeting.length-1)]
  rescue
    return []
  end

end
