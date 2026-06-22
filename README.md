# Infinite Stack Homebrew Tap

Private Homebrew tap for Infinite Stack tools.

## Jarvis

```bash
brew tap roughcoder/infinite-stack git@github.com:roughcoder/homebrew-infinite-stack.git
brew trust --tap roughcoder/infinite-stack
export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
brew install --cask jarvis-app
xattr -dr com.apple.quarantine /Applications/Jarvis.app
```

Upgrade:

```bash
brew trust --tap roughcoder/infinite-stack
export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
brew upgrade --cask jarvis-app
xattr -dr com.apple.quarantine /Applications/Jarvis.app
```

The quarantine removal is for the current private testing phase, while Jarvis
is ad-hoc signed instead of Developer ID signed and notarized.
