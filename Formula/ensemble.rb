class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.21"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.21/ensemble-cli-0.4.21-darwin-arm64.tar.gz"
      sha256 "103a3c537808b7041b4a0db20f75a024c3b3d489aaf83999188f4940a6b2d0b2"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.21/ensemble-cli-0.4.21-darwin-x64.tar.gz"
      sha256 "f554aa6073ee8949b7daf4c6df1eeb449572ca9b5e7194cf295f5ff5703345d6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.21/ensemble-cli-0.4.21-linux-arm64.tar.gz"
      sha256 "41c9ff3431ccb2fd92e2f963944722293863f667ea864864dc45ec8f163809cb"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.21/ensemble-cli-0.4.21-linux-x64.tar.gz"
      sha256 "e287fb8c55a761d1958752d24ec997d3cc05c53f752a1129767ddea918255b98"
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
