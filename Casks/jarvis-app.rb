cask "jarvis-app" do
  version "0.2.2"
  sha256 "65d29c055b87774e1060d6f20052b3383a50e1f03c8dfe8700b31bbef62fde7a"

  url "https://api.github.com/repos/roughcoder/jarvis-apple/releases/assets/454598933?version=#{version}",
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
    Before installing or upgrading, expose a token with repo read access:

      export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"

    Until Jarvis has Developer ID signing and notarization, install with:

      brew install --cask --no-quarantine jarvis-app
  EOS
end
