require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".roster-cards-container .student-card").collect do |student|
      {:name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value}
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    student[:bio] = doc.css(".details-container .description-holder p").text
    doc.css(".social-icon-container a").each do |x|
      social_a = x.attribute("href").value
      student[:twitter] = social_a if social_a.include?("twitter")
      student[:linkedin] = social_a if social_a.include?("linkedin")
      student[:github] = social_a if social_a.include?("github")
      student[:blog] = social_a unless social_a.include?("twitter") || social_a.include?("linkedin") || social_a.include?("github")
    end
    student[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    student
  end

end
