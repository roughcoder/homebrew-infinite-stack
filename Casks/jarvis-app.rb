cask "jarvis-app" do
  version "0.2.4"
  sha256 "d68e54fd1cdfdc3a49965254279921ef2b05e47e4f440b6166338ef95959a605"

  url "https://api.github.com/repos/roughcoder/jarvis-apple/releases/assets/454645522?version=#{version}",
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

    Until Jarvis has Developer ID signing and notarization, install with:

      brew install --cask --no-quarantine jarvis-app
  EOS
end
