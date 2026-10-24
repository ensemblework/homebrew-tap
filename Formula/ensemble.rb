class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.11"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.11/ensemble-cli-0.4.11-darwin-arm64.tar.gz"
      sha256 "78fa4b1dd38d21ceee1b625c1618901bd794ebe71a36084202e15d3f4758424a"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.11/ensemble-cli-0.4.11-darwin-x64.tar.gz"
      sha256 "88d7d63610ed887b0f95d2b107fd4ccd2f92247146dfa73462dec1ed3162ac08"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.11/ensemble-cli-0.4.11-linux-arm64.tar.gz"
      sha256 "30032a3509e1075b93e2e861711203c75a9ef9a3bad36dd761cc118395e8809e"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.11/ensemble-cli-0.4.11-linux-x64.tar.gz"
      sha256 "08189a2ff597ebd9eaf393007c0cfce558d88b20f48f27485d693d63362f4077"
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
