module ApplicationHelper
  require "uri"

  def convert_url_into_a_tag(text)
    text.gsub(URI.regexp(['http', 'https'])) do |text|
      "<a href='#{text}'>#{text}</a>"
    end
  end

  def full_title(page_name = "")
    base_title = "Task App"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
end