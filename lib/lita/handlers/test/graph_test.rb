require_relative "../src/graph"
require "test/unit"

class TestGraph < Test::Unit::TestCase

  def test_xml_import

  end

  def test_graph_construction

  end

  def test_node_lookup

  end

  def test_circles

  end

  def test_search_path

  end

  def test_anfragen
    assert_equal( ["Hörsaal 1","Audimax"], get_start_stop("Ich will vom Hörsaal 1 zum Audimax") )
  end

end