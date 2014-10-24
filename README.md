# crepe-versioning [![Build Status][1]][2] [![Code Climate][3]][4]

Add versioning support to your [Crepe][crepe] APIs.

[1]: https://img.shields.io/travis/crepe/crepe-versioning.svg?style=flat
[2]: https://travis-ci.org/crepe/crepe-versioning
[3]: https://img.shields.io/codeclimate/github/crepe/crepe-versioning.svg?style=flat
[4]: https://codeclimate.com/github/crepe/crepe-versioning
[crepe]: https://github.com/crepe/crepe

## Installation

In your Gemfile:

```ruby
gem 'crepe-versioning'
```

## Usage

crepe-versioning supports three different versioning strategies:

 * In the path (the default)
 * In the Accept header
 * In a query parameter

```ruby
require 'crepe'
require 'crepe/versioning'

# Demonstrates versioning your API in several ways:
#
#   $ curl 0.0.0.0:9292/?v=v1
#   {"message":"Version 1"}
#   $ curl 0.0.0.0:9292/v2
#   {"message":"Version 2"}
#   $ curl -H 'Accept: application/vnd.crepe-3+json' 0.0.0.0:9292
#   {"message":"Version 3"}
class Versioned < Crepe::API
  # Equivalent to `version :v2 do ... end`
  version :v2, with: :path do
    get do
      { message: 'Version 2' }
    end
  end

  # Experimental version 3
  version :v3, with: :header, vendor: 'crepe' do
    get do
      { message: 'Version 3' }
    end
  end

  version :v1, with: :query, name: 'v' do
    get do
      { message: 'Version 1' }
    end
  end
end

run Versioned
```

The first defined version will be the default version (`:v2`, in the above case). You can also set namespace-wide configuration for your versions, including setting a default. For example:

```ruby
require 'crepe'
require 'crepe/versioning'

# Demonstrates less repetitive version configuration:
#
#   $ curl 0.0.0.0:9292
#   {"message":"Version 2"}
#   $ curl -H 'Accept: application/vnd.crepe-1+json' 0.0.0.0:9292
#   {"message":"Version 1"}
class Versioned < Crepe::API
  version with: :header, vendor: 'crepe', default: :v2

  version :v1 do
    get do
      { message: 'Version 1' }
    end
  end

  version :v2 do
    get do
      { message: 'Version 2' }
    end
  end
end

run Versioned
```

## License

crepe-versioning is licensed under [The MIT License](LICENSE.txt).
