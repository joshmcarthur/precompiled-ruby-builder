# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'pry'

module PrecompiledRubyBuilder
  ##
  # Downloads and parses Ruby releases from the ruby-lang news page
  class ReleasesFromRSS
    def initialize(feed_uri)
      @feed_uri = feed_uri
    end

    # rubocop:disable Security/Open - we are using OpenURI#open
    def open_document
      @document = Nokogiri::XML(open(@feed_uri).read)
    end
    # rubocop:enable Security/Open - we are using OpenURI#open

    def process_item(item)
      item = Nokogiri::HTML(item.text)
      downloads_section = item.css('h2:contains("Download")').first
      return unless downloads_section

      process_download(downloads_section.next_element.css('li').first)
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
      @document
        .css('item > description')
        .map(&method(:process_item))
        .compact
    end

    def releases
      @releases ||= begin
                      open_document
                      process_items
                    end
    end
  end
end
