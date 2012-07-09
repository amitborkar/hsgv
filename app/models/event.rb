require 'csv'
require 'net/http'
require 'hpricot'
require 'faster_csv'

class Event < ActiveRecord::Base  
  FROM_FILE, FROM_USTREAM = 0, 1
  
  SOURCES = { FROM_FILE => "File", FROM_USTREAM => "UStream" }
  
  def self.import_from_file(file_name)
    count = 0
    CSV::Reader.parse(file_name).each do |row|
      Rails.logger.debug row.to_s
      unless Event.exists?(row[0])
        Event.create(:title => row[1], :committee_id => row[2], :start_date => row[3], :source => FROM_FILE)
      end
      count = count + 1
    end
    count
  end
  
  def self.pull_from_ustream
    response = Net::HTTP.get_response(URI.parse("http://api.ustream.tv/xml/video/recent/search/userID:eq:12987475?page=N"))
    events = Array.new
    
    doc = Hpricot::XML(response.body)      
    Rails.logger.debug doc.to_s
    (doc/"array").each do |item|
      unless Event.exists?(:ustream_archive_id => (item/"id").inner_text)
        description = (item/"description").inner_text.split('-')
        committee_id = description.first[2..-1].upcase
        if description[2] && description[3]
          start_date = DateTime.parse(description[2].to_s + (description[3].to_s[0..3]))
        else
          start_date = DateTime.parse((item/"createdAt").inner_text)
        end
        event = Event.create(:start_date => start_date, :ustream_archive_id => (item/"id").first.inner_text, :source => FROM_USTREAM, :title => (item/"title").inner_text, :committee_id => committee_id)
      end
      events.push(event)
    end
  end
end