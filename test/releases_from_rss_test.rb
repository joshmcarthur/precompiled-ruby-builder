# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../releases_from_rss'

module PrecompiledRubyBuilder
  describe ReleasesFromRSS do # rubocop:disable Metrics/BlockLength
    # rubocop:disable Metrics/LineLength
    it 'derives expected releases from a release-only RSS feed' do
      path = fixture_file_path('release-rss.xml')
      parser = ReleasesFromRSS.new(path)
      releases = parser.releases
      assert_equal releases, [
        {
          file: 'https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.0-preview1.tar.gz',
          meta: {
            'SIZE' => '16021286',
            'SHA1' => '2fbecf42b03a9d4391b81de42caec7fa497747cf',
            'SHA256' => 'c44500af4a4a0c78a0b4d891272523f28e21176cf9bc1cc108977c5f270eaec2',
            'SHA512' => 'f731bc9002edd3a61a4955e4cc46a75b5ab687a19c7964f02d3b5b07423d2360d25d7be5df340e884ca9945e3954e68e5eb11b209b65b3a687c71a1abc24b91f'
          }
        }
      ]
    end
    # rubocop:enable Metrics/LineLength

    it 'correctly derives no releases from a news-only RSS feed' do
      path = fixture_file_path('news-only-rss.xml')
      parser = ReleasesFromRSS.new(path)
      releases = parser.releases
      assert releases.empty?
    end

    # rubocop:disable Metrics/LineLength
    it 'derives expected releases from a mixed RSS feed' do
      path = fixture_file_path('mixture-rss.xml')
      parser = ReleasesFromRSS.new(path)
      releases = parser.releases
      assert_equal releases, [
        {
          file: 'https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.0-preview1.tar.gz',
          meta: {
            'SIZE' => '16021286',
            'SHA1' => '2fbecf42b03a9d4391b81de42caec7fa497747cf',
            'SHA256' => 'c44500af4a4a0c78a0b4d891272523f28e21176cf9bc1cc108977c5f270eaec2',
            'SHA512' => 'f731bc9002edd3a61a4955e4cc46a75b5ab687a19c7964f02d3b5b07423d2360d25d7be5df340e884ca9945e3954e68e5eb11b209b65b3a687c71a1abc24b91f'
          }
        }
      ]
    end
    # rubocop:enable Metrics/LineLength

    it 'raises an error if the feed is not found' do
      assert_raises OpenURI::HTTPError do
        ReleasesFromRSS.new('http://example.com/notfound').releases
      end
    end

    private

    def fixture_file_path(filename)
      File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', filename))
    end
  end
end
