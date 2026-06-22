cask "jarvis-app" do
  version "0.2.9"
  sha256 "9835e5e554cda3eabebbf48ad46513fc170b3e6b0f5638bf9cf26bf2c8bfa27d"

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
