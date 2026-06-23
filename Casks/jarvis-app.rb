cask "jarvis-app" do
  version "0.2.30"
  sha256 "913033806c728cb629b59ee627c86ca5dc798302e2d5a419fd8f4983fe68b80c"

  url "https://github.com/roughcoder/jarvis-apple/releases/download/v#{version}/Jarvis-macos.zip"
  name "Jarvis"
  desc "Observe and safely control local Jarvis roles"
  homepage "https://github.com/roughcoder/jarvis-apple"

  depends_on formula: "jarvis"
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
