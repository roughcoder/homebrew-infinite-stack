cask "jarvis-app" do
  version "0.2.16"
  sha256 "8a79b4787df84a82c6303cd2fb6b92375e870c395288387ab5ea74191b04587b"

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
