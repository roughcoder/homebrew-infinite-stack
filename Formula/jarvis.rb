class Jarvis < Formula
  desc "Local-first Jarvis voice assistant runtime"
  homepage "https://github.com/roughcoder/jarvis"
  url "https://github.com/roughcoder/jarvis/releases/download/v0.7.0/jarvis-0.7.0.tar.gz"
  sha256 "f5688cb3a391ca8fe9a7cb385b1569f3ed643f692cd9edcf9d2e46be6231cae1"
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
    prune_non_native_porcupine_libs

    (libexec/"bin").mkpath
    (libexec/"bin/jarvis").write <<~SH
      #!/usr/bin/env bash
      set -euo pipefail
      export PYTHONPATH="#{libexec}/src${PYTHONPATH:+:$PYTHONPATH}"
      export UV_PROJECT="#{libexec}"
      exec "#{formula_opt_bin("uv")}/uv" run python -m jarvis.cli "$@"
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

  def prune_non_native_porcupine_libs
    return unless OS.mac?

    native_arch = Hardware::CPU.arm? ? "arm64" : "x86_64"
    mac_libs = libexec/".venv/lib/python3.12/site-packages/pvporcupine/lib/mac"
    return unless mac_libs.directory?

    mac_libs.children.each do |path|
      rm_r path if path.directory? && path.basename.to_s != native_arch
    end
  end
end
