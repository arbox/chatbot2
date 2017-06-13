require_relative "../src/anfragen"
require "test/unit"

class TestAnfragen < Test::Unit::TestCase

  def test_anfragen
    assert_equal( ["Bib","Mensa"], get_start_stop("Ich will von der Bib zur Mensa") )
    assert_equal( ["Bib","Mensa"], get_start_stop("Wie komme ich von der Bib zur Mensa.") )
    assert_equal( ["Mensa","Bib"], get_start_stop("Wie komme ich von der Mensa zur Bib.") )
  end

end
