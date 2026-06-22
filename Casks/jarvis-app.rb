cask "jarvis-app" do
  version "0.2.5"
  sha256 "ced97d485fee3e1d620dad8d8743f88768cb7f42dc20569b36f247d1d43c3f13"

  url "https://api.github.com/repos/roughcoder/jarvis-apple/releases/assets/454654923?version=#{version}",
      header: [
        "Accept: application/octet-stream",
        "Authorization: Bearer #{ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", nil)}",
      ]
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
    Jarvis is currently distributed from a private GitHub release.
    Before installing or upgrading, trust the tap and expose a token with repo
    read access:

      brew trust --tap roughcoder/infinite-stack
      export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"

    Until Jarvis has Developer ID signing and notarization, clear quarantine
    after install or upgrade:

      /usr/bin/xattr -dr com.apple.quarantine "#{appdir}/Jarvis.app"
  EOS
end
