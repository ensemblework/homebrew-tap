class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.8"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.8/ensemble-cli-0.7.8-darwin-arm64.tar.gz"
      sha256 "772a3f70d63e4f8cccb1ad21a8a545a86f2fe09f4a47f0e9597deabc2a144ab2"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.8/ensemble-cli-0.7.8-darwin-x64.tar.gz"
      sha256 "71d30bab5f1a09091965f243714d0039f1c9f2e4dfcb1ef45760ce271f8bbd08"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.8/ensemble-cli-0.7.8-linux-arm64.tar.gz"
      sha256 "a63e9a4d9d2aa6c2ef67f48a1f4e7347d3bb693ade27d41440a078fed5088fb4"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.8/ensemble-cli-0.7.8-linux-x64.tar.gz"
      sha256 "abcc3051b18dc5b4e5cbe54652fc33f1f8362b009e206f791a6f64c3f528a709"
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
