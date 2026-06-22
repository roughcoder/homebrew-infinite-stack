cask "jarvis-app" do
  version "0.2.5"
  sha256 "ced97d485fee3e1d620dad8d8743f88768cb7f42dc20569b36f247d1d43c3f13"

  url "https://github.com/roughcoder/jarvis-apple/releases/download/v#{version}/Jarvis-macos.zip"
  name "Jarvis"
  desc "Observe and safely control local Jarvis roles"
  homepage "https://github.com/roughcoder/jarvis-apple"

  depends_on macos: :sonoma

  app "Jarvis.app"

  zap trash: [
    "~/Library/Logs/Jarvis",
    "~/Library/Preferences/dev.infinitestack.jarvis.mac.plist",
  ]

  caveats <<~EOS
    Until Jarvis has Developer ID signing and notarization, macOS may require
    quarantine removal after install or upgrade:

      /usr/bin/xattr -dr com.apple.quarantine "#{appdir}/Jarvis.app"
  EOS
end
