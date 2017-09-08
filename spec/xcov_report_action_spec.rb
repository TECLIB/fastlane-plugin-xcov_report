describe Fastlane::Actions::XcovReportAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The xcov_report plugin is working!")

      Fastlane::Actions::XcovReportAction.run(nil)
    end
  end
end
