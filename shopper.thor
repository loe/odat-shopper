require 'thor'
require 'nokogiri'
require 'open-uri'

class Shopper < Thor
  URL = 'http://rss.whiskeymilitia.com/docs/wm/rss.xml'

  desc "shop", "Find sweet deals that match REGEX."
  def shop(pattern = '.*')
    regexp = Regexp.new(pattern, true) # Second argument makes Regexp case insensitive.
    doc = Nokogiri::XML(open(URL))
    doc.xpath('//item').select do |item|
      item.xpath('title').inner_text =~ regexp
    end.map do |item|
      puts item.xpath('title').inner_text
    end
  end
end
