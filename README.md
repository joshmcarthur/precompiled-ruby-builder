# Precompiled Ruby Builder

This project provides helper scripts to automatically download and precompile Ruby binaries for various platforms.
Intitially, support will focus on Ruby compiled for Amazon Linux via Lambda functions. Support for other ecosystems/
architectures is planned.

## Getting Started

The project's dependencies can be installed by running `bundle install`. 
Ruby version 2.6 is preferred, and Ruby 2.5 is supported.

#### Getting a list of recent releases

The below code snippet demonstrates how to get recent Ruby versions published to the 
[Ruby RSS feed](https://www.ruby-lang.org/en/feeds/news.rss), complete with download links
and hash codes.

```
irb> require_relative "./releases_from_rss.rb"
irb> fetcher = PrecompiledRubyBuilder::ReleasesFromRSS.new("https://www.ruby-lang.org/en/feeds/news.rss")
irb> fetcher.releases
```

#### Download a Ruby source file to an S3 bucket with attached metadata [Coming soon]

#### Compile a Ruby version [Coming soon]

#### Report new Ruby version compiled [Coming soon]
.

## Contributing

Contributions are welcome. 

Ensure any testing or build dependencies are removed before committing your changes.
Running `rubocop` before you commit will reveal linting problems before they make their way into the commit log, 
and may save a rebase.
Update the README.md with details of changes to the available script commands.
You may merge the Pull Request in once you have the sign-off of at least one other developer, 
or if you do not have permission to do that, you may request the second reviewer to merge it for you.

## License

precompiled-ruby-builder is copyright © 2019 Josh McArthur <https://joshmcarthur.com>
It is free software, and may be redistributed under the terms specified in the 
[LICENSE](https://github.com/joshmcarthur/precompiled-ruby-versions/blob/master/LICENSE.txt) file.
