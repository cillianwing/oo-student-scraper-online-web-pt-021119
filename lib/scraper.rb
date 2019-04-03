require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #name = doc.css(".roster-cards-container .student-name").text
    #location = doc.css(".roster-cards-container .studen-location").text
    #profile_url = doc.css(".roster-cards-container a")
    #binding.pry
    student_array = []
    doc.css(".roster-cards-container .student-card").each do |student|
      binding.pry
      student_array.push({:name => doc.css(".roster-cards-container .student-name").text,
        :location => doc.css(".roster-cards-container .studen-location").text,
        :profile_url => doc.css(".roster-cards-container a")})
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)

  end

end
