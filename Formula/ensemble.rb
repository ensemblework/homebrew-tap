class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.7.3"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.3/ensemble-cli-0.7.3-darwin-arm64.tar.gz"
      sha256 "0c2beece2b4313c5c614bd2edd453928cee731feb4d621e0d2ffd88b44140956"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.3/ensemble-cli-0.7.3-darwin-x64.tar.gz"
      sha256 "9c59b3fe5c46966464fa73fa2c1a87c6bdb9e5758c7fa7249e9cd799f5d862ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.3/ensemble-cli-0.7.3-linux-arm64.tar.gz"
      sha256 "3cfeda3b0cfb6c0e98a364e5d8fd10d0596d24b1e255baca71f30215e336eef3"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.7.3/ensemble-cli-0.7.3-linux-x64.tar.gz"
      sha256 "5f7a0a5f450804d2b5e035d74c316fc4ccaa3beddc4b2223299f9e52248aa9aa"
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
