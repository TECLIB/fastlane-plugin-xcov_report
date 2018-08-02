export CURRENT_VERSION=$(jq -r ".version" package.json)
npm run release
export NEW_VERSION=$(jq -r ".version" package.json)
ruby ./ci/scripts/change_plugin_version.rb CURRENT_VERSION NEW_VERSION
gem build your-gem-name.gemspec
gem push "fastlane-plugin-xcov_report-$NEW_VERSION.gem"