require 'thor'
require 'nokogiri'
require 'open-uri'
require 'mail'

$stdout.sync = true

Mail.defaults do
  delivery_method :smtp, {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :authentication => :plain,
    :enable_starttls_auto => true
  }
end

class Shopper < Thor
  URL = ENV['RSS_URL']

  desc "shop", "Find sweet deals that match REGEX."
  def shop(pattern = ENV['PATTERN'])
    pattern ||= '.*'
    puts "Shopping for #{pattern} on #{URL}."
    regexp = Regexp.new(pattern, true) # Second argument makes Regexp case insensitive.
    doc = Nokogiri::XML(open(URL))
    item = doc.xpath('//item').first

    if item.xpath('title').inner_text =~ regexp
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
