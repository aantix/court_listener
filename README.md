# Court Listener Search Gem

A simple Ruby wrapper around the Court Listener API.

Useful for querying cases for a given jurisdiction.

https://www.courtlistener.com/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'court_listener'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install court_listener

## Usage

```
  court    = CourtListener::Search.new(<API Key>)

  courts   = CourtListener::Search.jurisdictions_for(state: params[:location])   
  options  = {type: 'o', 
              order_by: 'score desc',
              q: <Query String>}

  options.merge!(court: courts) if courts.present?

  results = court.search(options)
```
