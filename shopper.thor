require 'thor'
require 'nokogiri'
require 'open-uri'

class Shopper < Thor
  URL = 'http://rss.whiskeymilitia.com/docs/wm/rss.xml'

  def initialize
    @doc = Nokogiri::XML(open(URL))
  end

  desc "shop", "Find sweet deals."
  def shop
    puts @doc.xpath('//item')
  end
end
