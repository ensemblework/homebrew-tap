class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.18"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.18/ensemble-cli-0.7.18-darwin-arm64.tar.gz"
      sha256 "b510fee497fb2facd55a7a4b543796eadd980fef319a23fe97793fa49402bb38"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.18/ensemble-cli-0.7.18-darwin-x64.tar.gz"
      sha256 "5f61508dcb04272751d9ef4b6ee4789a90a3e59dbf4166ed4224f259d5e824ea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.18/ensemble-cli-0.7.18-linux-arm64.tar.gz"
      sha256 "7fcb5e53e9e095d327a33efabdc4d9b9483d468e44ba14d8829d5f6675475bd1"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.18/ensemble-cli-0.7.18-linux-x64.tar.gz"
      sha256 "ea17e392f1359e2c58faa389abd4960d75e37fa3ad1a3f59c8c594a7961dc9c5"
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
