export CURRENT_VERSION=$(jq -r ".version" package.json)
npm run release -- --prerelease 'rc'
export NEW_VERSION=$(jq -r ".version" package.json)
ruby ./ci/scripts/change_plugin_version.rb $CURRENT_VERSION $NEW_VERSION

gem build fastlane-plugin-xcov_report.gemspec
gem push *.gem