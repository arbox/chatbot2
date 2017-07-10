require_relative "../src/anfragen"
require "test/unit"

class TestAnfragen < Test::Unit::TestCase

  def test_anfragen

    # will not match, because the answer is a random entry from a list
    #assert_equal( "Hi", get_start_stop("Hallo ") )

    assert_equal( ["Hörsaal 1","Audimax"], get_start_stop("Ich will vom Hörsaal 1 zum Audimax") )

    assert_equal( ["zweiten Stock des B-Gebäudes","vierten Stock des B-Gebäudes"], get_start_stop("Wie komme ich vom zweiten Stock des B-Gebäudes in den vierten Stock des B-Gebäudes") )

    assert_equal( ["Eingangsbereich der Mensa","Erdgeschoss des N-Gebäudes"], get_start_stop("Ich will vom Eingangsbereich der Mensa zum Erdgeschoss des N-Gebäudes") )

    assert_equal( ["Haupteingang des Mensa-Gebäudes","Hintereingang des N-Gebäudes"], get_start_stop("Ich will vom Haupteingang des Mensa-Gebäudes zum Hintereingang des N-Gebäudes") )

    assert_equal( ["Haupteingang des N-Gebäudes","Eingang des V-Gebäudes"], get_start_stop("Ich will vom Haupteingang des N-Gebäudes zum Eingang des V-Gebäudes") )
  end

end
