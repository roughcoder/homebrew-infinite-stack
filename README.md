# Infinite Stack Homebrew Tap

Homebrew tap for Infinite Stack tools.

## Jarvis

Fresh Mac install:

```bash
brew tap roughcoder/infinite-stack
brew trust --formula roughcoder/infinite-stack/jarvis
brew trust --cask roughcoder/infinite-stack/jarvis-app
brew install jarvis
brew install --cask jarvis-app
xattr -dr com.apple.quarantine /Applications/Jarvis.app
open -a Jarvis
```

Runtime formula:

```bash
brew tap roughcoder/infinite-stack
brew trust --formula roughcoder/infinite-stack/jarvis
brew install jarvis
jarvis service sync brain worker intercom
jarvis service install brain
jarvis service install worker
jarvis service install intercom
```

Native macOS app:

```bash
brew tap roughcoder/infinite-stack
brew trust --cask roughcoder/infinite-stack/jarvis-app
brew install --cask jarvis-app
xattr -dr com.apple.quarantine /Applications/Jarvis.app
```

Upgrade:

```bash
brew update
brew trust --formula roughcoder/infinite-stack/jarvis
brew trust --cask roughcoder/infinite-stack/jarvis-app
brew upgrade jarvis
jarvis service sync brain worker intercom
brew upgrade --cask jarvis-app
xattr -dr com.apple.quarantine /Applications/Jarvis.app
```

The quarantine removal is needed while Jarvis is ad-hoc signed instead of
Developer ID signed and notarized.

For runtime development builds, use `brew install --HEAD jarvis` or
`brew upgrade --fetch-HEAD jarvis`.
