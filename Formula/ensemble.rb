class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.4.10"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.10/ensemble-cli-0.4.10-darwin-arm64.tar.gz"
      sha256 "c19b336f6715bea9b27b597a7c4ff6f5b9edc4ee9d05c11a8bceb88628ccf8bd"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.10/ensemble-cli-0.4.10-darwin-x64.tar.gz"
      sha256 "51945b8ea32325d8f971c14054b3f90d546faf8a90c61fb3731686d927776442"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.10/ensemble-cli-0.4.10-linux-arm64.tar.gz"
      sha256 "dc45d0c1bcf4bcd95685618f08e73f1c75b0eff9d560efe8616cf6ce9cc2648d"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.4.10/ensemble-cli-0.4.10-linux-x64.tar.gz"
      sha256 "bc1bbe99eaf77805a3532c7c32bd0bfa4a43e5f44dced6934f5f5932a1b03e80"
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
