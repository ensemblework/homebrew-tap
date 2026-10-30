class Ensemble < Formula
  desc "Ensemble CLI: run tasks assigned from ensemblework.com on your computer, and connect your editor to Ensemble over MCP."
  homepage "https://ensemblework.com/download"
  # Explicit: from the URLs Homebrew would read "64" (darwin-arm64), so upgrades never showed.
  # version_scheme 1 makes kegs installed as "64" count as outdated.
  version "0.5.1"
  version_scheme 1
  license "FSL-1.1-MIT"

  on_macos do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.1/ensemble-cli-0.5.1-darwin-arm64.tar.gz"
      sha256 "73cd2c8f9d931be036f59f5c89e5cd6d56d17a580e5b4f883e2a0d1195b9d86c"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.1/ensemble-cli-0.5.1-darwin-x64.tar.gz"
      sha256 "c69f2f557ce70c86fdc8c03cf057ae900ad3ca8d87978c6c35f1e21ee6fc53e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.1/ensemble-cli-0.5.1-linux-arm64.tar.gz"
      sha256 "a6ae400a4aa0b41fdba484059494069e53bddbf34c9770ad6334e29cb6020b94"
    end

    on_intel do
      url "https://github.com/ensemblework/ensemble/releases/download/cli-v0.5.1/ensemble-cli-0.5.1-linux-x64.tar.gz"
      sha256 "ae33ce294c6c95f91e8d0c9ab091a5f6f8d7a6893e896a53ed5342f1aaaaedfa"
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
