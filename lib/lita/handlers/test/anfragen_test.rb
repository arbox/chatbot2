require_relative "../src/anfragen"
require "test/unit"

class TestAnfragen < Test::Unit::TestCase

  def test_anfragen
    assert_equal( ["Bib","Mensa"], get_start_stop("Ich will von der Bib zur Mensa") )

    assert_equal( ["Bib","Mensa"], get_start_stop("Wie komme ich von der Bib zur Mensa.") )

    assert_equal( ["Mensa","Bib"], get_start_stop("Wie komme ich von der Mensa zur Bib.") )

    assert_equal( ["A337","B329"], get_start_stop("Zeig mir den Weg von A337 zum Raum B329.") )

    #assert_equal( ["A337","DM-Gebäude"], get_start_stop("Zeig mir den Weg von A337 zum DM-Gebäude.") )

    assert_equal( "Hi", get_start_stop("Hallo ") )
  end

end
