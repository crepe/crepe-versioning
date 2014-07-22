require 'crepe/api'

require 'crepe/versioning/accept'
require 'crepe/versioning/request'
require 'crepe/versioning/version'

module Crepe

  # Add API versioning support to Crêpe.
  module Versioning

    # Specifies a version:
    #
    #   version :v1 do
    #     # ...
    #   end
    #
    # Crepe supports versioning by path prefix, header, or query string.
    # Path-based versioning is the default (so the above behaves much like
    # {.scope}, namespacing its endpoints with a '/v1' path component).
    #
    # To use header-based versioning (versioning by content negotiation),
    # configure versioning before any specific versions are declared:
    #
    #   version with: :header, vendor: 'my-app'
    #
    #   version :v1 do
    #     # ...
    #   end
    #
    # To explicitly match a route in the above scope, set your request's
    # accept header:
    #
    #   Accept: application/vnd.my-app-v1+json
    #
    # In case you want to version with a query parameter:
    #
    #   version with: :query, name: 'v'
    #
    # With header or query parameter versioning, the first version declared
    # will be considered the default, and requests that are not explicitly
    # versioned will be directed to it. Alternatively, you can specify a
    # default version explicitly:
    #
    #   version with: :header, vendor: 'my-app', default: :v1
    #
    # @return [void]
    # @see .scope
    def version level = nil, **options, &block
      config[:version][:default] ||= level
      with = options.fetch :with, config[:version][:with]
      path = level if with == :path
      scope path, version: options.merge(level: level, with: with), &block
    end

    private

    # Add API versioning conditions to support mounting Rack applications into
    # a {.version} scope.
    #
    # @param [String] path_info a path at which the app will be mounted
    # @param [String] method the HTTP request method to use for the app
    # @return [Hash] conditions to pass to Rack::Mount
    # @api public
    def mount_conditions path_info, method
      conditions = super

      if level = config[:version][:level]
        case config[:version][:with]
          when :query  then conditions[:query_version]   = /\A#{level}\Z/
          when :header then conditions[:header_versions] = /\A#{level}\Z/
        end
      end

      conditions
    end

  end

end

module Crepe
  class API
    class << self
      prepend Crepe::Versioning
    end

    @config[:version] = {
      name: 'v',
      with: :path
    }
  end
end
