require 'thor'
require 'nokogiri'
require 'open-uri'
require 'mail'

class Shopper < Thor
  URL = ENV['RSS_URL']

  desc "shop", "Find sweet deals that match REGEX."
  def shop(pattern = '.*')
    regexp = Regexp.new(pattern, true) # Second argument makes Regexp case insensitive.
    doc = Nokogiri::XML(open(URL))
    doc.xpath('//item').select do |item|
      item.xpath('title').inner_text =~ regexp
    end.map do |item|
      subject = item.xpath('title').inner_text
      link = item.xpath('link').inner_text
      puts "Sending mail about #{subject}"
      Mail.deliver do
        from    ENV['MAIL_FROM']
        to      ENV['MAIL_TO']
        subject subject
        body    link
      end
    end
  end
end
