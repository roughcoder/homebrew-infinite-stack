cask "jarvis-app" do
  version "0.2.29"
  sha256 "9b2c7c6f129834c8ff340e7c1387703e39d0863e4f5ff53d600c1c0e5920c18b"

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
