class Jarvis < Formula
  desc "Local-first Jarvis voice assistant runtime"
  homepage "https://github.com/roughcoder/jarvis"
  url "https://github.com/roughcoder/jarvis/releases/download/v0.1.7/jarvis-0.1.7.tar.gz"
  sha256 "bc0e97cc20cceb0212da7b07384e257f9999220d3bd2c73318bec880587d9b3f"
  head "https://github.com/roughcoder/jarvis.git", branch: "main"

  depends_on "python@3.12"
  depends_on "uv"

  def install
    libexec.install Dir["*"]
    inreplace libexec/"pyproject.toml",
              'readme = "README.md"',
              'readme = { text = "Jarvis runtime", content-type = "text/markdown" }'

    cd libexec do
      system formula_opt_bin("uv")/"uv", "sync", "--no-dev", "--no-editable"
    end

    (libexec/"bin").mkpath
    (libexec/"bin/jarvis").write <<~SH
      #!/usr/bin/env bash
      set -euo pipefail
      cd "#{libexec}"
      export UV_NO_EDITABLE="${UV_NO_EDITABLE:-1}"
      exec "#{formula_opt_bin("uv")}/uv" run --no-sync jarvis "$@"
    SH
    chmod 0755, libexec/"bin/jarvis"

    bin.install_symlink libexec/"bin/jarvis"
  end

  def caveats
    <<~EOS
      Jarvis runtime is installed as the `jarvis` command.

      Install local services with:
        jarvis service sync brain
        jarvis service install brain
        jarvis service sync worker
        jarvis service install worker
        jarvis service sync intercom
        jarvis service install intercom

    EOS
  end

  test do
    assert_match "jarvis", shell_output("#{bin}/jarvis --version")
  end
end
