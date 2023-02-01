require 'bundler'
Bundler.require
$:.unshift File.expand_path('lib', __dir__)
require 'app/scrap_email'
Dotenv.load('.env')

def saveas_json
  File.write("./db/emails.JSON", ScrapEmail.new.perform_tohash("http://www.annuaire-des-mairies.com/val-d-oise.html").to_json)
end

=begin
def saveas_spreadsheet
  #File.write("./db/emails.JSON", ScrapEmail.new.perform_tohash("http://www.annuaire-des-mairies.com/val-d-oise.html").to_json)
  session = GoogleDrive::Session.from_config("config.json")
  
end
saveas_spreadsheet
=end

def saveas_csv
  emails_csv = ScrapEmail.new.perform_tohash("http://www.annuaire-des-mairies.com/val-d-oise.html")
  CSV.open("db/emails.csv", "wb") do |csv|
    emails_csv.each { |key, value|
      csv << [key, value]
    }
  end
end
saveas_csv