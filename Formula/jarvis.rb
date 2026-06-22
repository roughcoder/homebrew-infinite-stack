class Jarvis < Formula
  desc "Local-first Jarvis voice assistant runtime"
  homepage "https://github.com/roughcoder/jarvis"
  url "https://github.com/roughcoder/jarvis/releases/download/v0.1.1/jarvis-0.1.1.tar.gz"
  sha256 "09c7c919253e33b9d884ba0ec07fdec9641881813fbe8ac28c99a9d30b22f8bf"
  head "https://github.com/roughcoder/jarvis.git", branch: "main"

  depends_on "python@3.12"
  depends_on "uv"

  def install
    libexec.install Dir["*"]

    cd libexec do
      system Formula["uv"].opt_bin/"uv", "sync", "--no-dev",
             "--extra", "gateway",
             "--extra", "tts",
             "--extra", "stt",
             "--extra", "vad",
             "--extra", "wake",
             "--extra", "memory",
             "--extra", "worker",
             "--extra", "mcp",
             "--extra", "browser"
    end

    (libexec/"bin").mkpath
    (libexec/"bin/jarvis").write <<~SH
      #!/usr/bin/env bash
      set -euo pipefail
      cd "#{libexec}"
      exec "#{Formula["uv"].opt_bin}/uv" run jarvis "$@"
    SH
    chmod 0755, libexec/"bin/jarvis"

    bin.install_symlink libexec/"bin/jarvis"
  end

  def caveats
    <<~EOS
      Jarvis runtime is installed as the `jarvis` command.

      Install local services with:
        jarvis service install brain
        jarvis service install worker
        jarvis service install intercom

    EOS
  end

  test do
    assert_match "jarvis", shell_output("#{bin}/jarvis --version")
  end
end
