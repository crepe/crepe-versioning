require 'crepe/versioning/accept'

module Crepe
  module Versioning
    module Request
      # Responds to #match so that Rack::Mount can route versions.
      class Versions < Array
        def match condition
          grep(condition).first
        end
      end

      def query_version
        (self.GET[self.class.config[:version][:name]] || default_version).to_s
      end

      def header_versions
        versions = accepts.media_types.map(&:version).compact
        versions << default_version.to_s if versions.empty? && default_version
        Versions.new versions
      end

      def accepts
        @accepts ||= Accept.new(
          Util.media_type(params[:format]) || headers['Accept'] || '*/*'
        )
      end

      private

      def default_version
        self.class.config[:version][:default]
      end
    end
  end
end

Crepe::Request.send(:include, Crepe::Versioning::Request)
