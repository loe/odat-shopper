odat-shopper
=======================

Efficiently shop One Deal at a Time sites like steepandcheap.com,
whiskeymilita.com, bonktown.com, and chainlove.com

You'll need to set some environment variables, this is designed to
run on Heroku.

MAIL_FROM:            you@gmail.com
MAIL_TO:              1235554545@txt.att.net
PATTERN:              nixon
RSS_URL:              http://rss.whiskeymilitia.com/docs/wm/rss.xml

Suggested Heroku Addons:
scheduler:standard
sendgrid:starter

Configure scheduler to check every 10 minutes.
