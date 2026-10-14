class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.3.8"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.8/ensemble-cli-0.3.8-darwin-arm64.tar.gz"
      sha256 "efa6654304b1973ca5f3ea8369b0a6a742338e55eebcef20624e134495facdff"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.8/ensemble-cli-0.3.8-darwin-x64.tar.gz"
      sha256 "6550bb37772c83f69e2a5fd8e4f9d8eceba7f163b74693a608c1a63f401f76b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.8/ensemble-cli-0.3.8-linux-arm64.tar.gz"
      sha256 "9c7a199439fa239ad015468be9c08862f0af5d88d9716883ded94256eb6f7ea6"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.3.8/ensemble-cli-0.3.8-linux-x64.tar.gz"
      sha256 "fbeace026be47185a3155572cf8010ed9a4a60ab6d51388afd24ad0ab2a99bb7"
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
