# Infinite Stack Homebrew Tap

Homebrew tap for Infinite Stack tools.

## Jarvis

Runtime formula:

```bash
brew tap roughcoder/infinite-stack
brew install --HEAD jarvis
jarvis service install brain
jarvis service install worker
jarvis service install intercom
```

Native macOS app:

```bash
brew tap roughcoder/infinite-stack
brew install --cask jarvis-app
xattr -dr com.apple.quarantine /Applications/Jarvis.app
```

Upgrade:

```bash
brew update
brew upgrade --fetch-HEAD jarvis
brew upgrade --cask jarvis-app
xattr -dr com.apple.quarantine /Applications/Jarvis.app
```

The quarantine removal is needed while Jarvis is ad-hoc signed instead of
Developer ID signed and notarized.
