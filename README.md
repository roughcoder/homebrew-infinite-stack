# Infinite Stack Homebrew Tap

Private Homebrew tap for Infinite Stack tools.

## Jarvis

```bash
brew tap roughcoder/infinite-stack git@github.com:roughcoder/homebrew-infinite-stack.git
export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
brew install --cask --no-quarantine jarvis-app
```

Upgrade:

```bash
export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
brew upgrade --cask jarvis-app
```

`--no-quarantine` is for the current private testing phase, while Jarvis is
ad-hoc signed instead of Developer ID signed and notarized.
