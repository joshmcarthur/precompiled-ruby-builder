require 'nokogiri'
require 'open-uri'
require "pry"

module PrecompiledRubyBuilder
  ##
  # Downloads and parses Ruby releases from the ruby-lang news page
  class ReleasesFromRSS
    def initialize(feed_uri)
      @feed_uri = URI.parse(feed_uri)
    end

    def open_document
      @document = Nokogiri::XML(@feed_uri.open.read)
    end

    def process_item(item)
      item = Nokogiri::HTML(item.text)
      downloads_section = item.css('h2:contains("Download")').first
      return unless downloads_section

      downloads_section.next_element.css('li').map(&method(:process_download))
    end

    def process_download(download)
      link = download.css("a[href^='https://cache.ruby-lang.org/pub/ruby']")
                     .first['href']
      meta = download.css('code').first.text
      { file: link, meta: extract_hashes(meta) }
    end

    def extract_hashes(meta)
      Hash[meta.scan(/([A-Z0-9]+)+:\s+([0-9a-f]+)/)]
    end

    def process_items
      @document.css('item > description').map(&method(:process_item))
    end

    def releases
      @releases ||= begin
                      open_document
                      process_items
                    end
    end
  end
end

