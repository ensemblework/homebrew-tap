class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.18"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.18/ensemble-cli-0.4.18-darwin-arm64.tar.gz"
      sha256 "ac3fc251a3624d26653b86a124f262f3af6f295e900f1cab3136ea1d0718ffd5"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.18/ensemble-cli-0.4.18-darwin-x64.tar.gz"
      sha256 "c506751d2fc86e56563a7daaecf7d0ffad5d587f79c3bdf1b1c688ecc4760d8a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.18/ensemble-cli-0.4.18-linux-arm64.tar.gz"
      sha256 "88ffc2c18ffa65c4cee46dd0d6ae22617a258e9476e5a6922cf71d49c92feae3"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.18/ensemble-cli-0.4.18-linux-x64.tar.gz"
      sha256 "cd719cc1e5344a0e2dd96ecca63de9d2cddca6af2832db16bab0664878617a96"
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
