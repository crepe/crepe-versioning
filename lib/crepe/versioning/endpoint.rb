require 'crepe/versioning/request'

module Crepe
  module Versioning
    module Endpoint
      # The most acceptable format requested, e.g. +:json+.
      #
      # @return [Symbol]
      def format
        return @format if defined? @format
        formats = Util.media_types config[:formats]
        media_type = request.accepts.best_of formats
        @format = config[:formats].find { |f| Util.media_type(f) == media_type }
      end
    end
  end
end

Crepe::Endpoint.send(:prepend, Crepe::Versioning::Endpoint)
