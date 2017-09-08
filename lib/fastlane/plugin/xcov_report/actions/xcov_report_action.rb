module Fastlane
  module Actions
    class XcovReportAction < Action
      def self.run(params)
        UI.message("The xcov_report plugin is working!")
        require "erb"
        require 'json'

        file = File.read(File.expand_path('fastlane-plugin-xcov_report/lib/fastlane/plugin/xcov_report/actions/page.html.erb'))
        data = JSON.parse(file)
        @coverage = data['coverage']
        @targets = data['targets']
        template = File.read(File.expand_path('coverage/page.html.erb'))
        renderer = ERB.new(template)
        result = renderer.result()

        open('coverage/index.html', 'w') do |f|
          f.puts result
        end

      end

      def self.description
        "Generate custom HTML for coverage"
      end

      def self.authors
        ["Gianfranco Manganiello"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Generates an HTML based on JSON generated from xcov"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "XCOV_REPORT_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
