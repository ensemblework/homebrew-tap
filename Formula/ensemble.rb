class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.6.5"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.5/ensemble-cli-0.6.5-darwin-arm64.tar.gz"
      sha256 "065a2b3b64d888e9a2033841450c69a3216db4e015e155821e910155cadd2d35"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.5/ensemble-cli-0.6.5-darwin-x64.tar.gz"
      sha256 "e8ccea448a3522fefbde91da59080eb3b0db20e91f171064f70edbbf1d85d225"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.5/ensemble-cli-0.6.5-linux-arm64.tar.gz"
      sha256 "7688e1d2c23858c611d2217eb89f99258fa2f0161ccf609ae0eb4da1f51a6743"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.6.5/ensemble-cli-0.6.5-linux-x64.tar.gz"
      sha256 "decd9c8fa37a80b043e6d09f2d275c3733a0202e0313caa34b014a1a1f8927bb"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/ensemble"
  end

  service do
    run [opt_bin/"ensemble", "runner", "start", "--foreground"]
    keep_alive true
    log_path var/"log/ensemble-runner.log"
    error_log_path var/"log/ensemble-runner.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ensemble --version")
  end
end
