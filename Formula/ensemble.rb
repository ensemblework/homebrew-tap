class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.5.0"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.0/ensemble-cli-0.5.0-darwin-arm64.tar.gz"
      sha256 "a7dca473df9d3c20a492a900a0cdf4b8f1df44d9f273625c30c2b7aa9422f930"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.0/ensemble-cli-0.5.0-darwin-x64.tar.gz"
      sha256 "9c461820c90a14f474cef3961a9656640d094dab79b8935b8aeccb826641b59b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.0/ensemble-cli-0.5.0-linux-arm64.tar.gz"
      sha256 "0cef10dcd14074b6d7f9964f6ef2e5e5cc5b3a9795f8ef74c843c289aa5bc65e"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.0/ensemble-cli-0.5.0-linux-x64.tar.gz"
      sha256 "9134b7bb9f406012d53451c169c3bfaa33ab38f8db15fd2ea7413f9012beb1fd"
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
